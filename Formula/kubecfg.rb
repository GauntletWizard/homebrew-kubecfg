class Kubecfg < Formula
  desc "Kubernetes management system based on jsonnet"
  homepage "http://ksonnet.heptio.com/"
  url "https://github.com/ksonnet/kubecfg.git",
    :tag => "v0.3.0",
    :revision => "8e2d8d4fc34a47ccc177ba835e621ca6afaa9d99"
  head "https://github.com/ksonnet/kubecfg.git"

  depends_on "go" => :build

  go_resource "k8s.io/client-go" do
    url "https://github.com/kubernetes/client-go.git",
        :revision => "e121606b0d09b2e1c467183ee46217fa85a6b672"
  end

  def install
    ENV["GOPATH"] = buildpath
    # arch = MacOS.prefer_64_bit? ? "amd64" : "x86"
    dir = buildpath/"src/github.com/ksonnet/kubecfg"
    dir.install buildpath.children - [buildpath/".brew_home"]

    cd dir do
      # Make binary
      system "make", "VERSION=homebrew-" + version, "kubecfg"
      bin.install "kubecfg"
    end
  end

  test do
    run_output = shell_output("#{bin}/kubecf 2>&1")
    assert_match "Synchronise Kubernetes resources with config files", run_output
  end

  #    version_output = shell_output("#{bin}/kubectl version --client 2>&1")
  #    assert_match "GitTreeState:\"clean\"", version_output
  #    assert_match stable.instance_variable_get(:@resource).instance_variable_get(:@specs)[:revision], version_output if build.stable?
end
