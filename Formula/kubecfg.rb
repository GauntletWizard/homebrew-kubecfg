class Kubecfg < Formula
  desc "Kubernetes management system based on jsonnet"
  homepage "https://http://ksonnet.heptio.com//"
  url "https://github.com/ksonnet/kubecfg.git",
    :tag => "v0.1.0",
      :revision => "d9e868667f63fe0c8c5155dc814b1d09a20dff5a"
  head "https://github.com/ksonnet/kubecfg.git"

#  bottle do
#    cellar :any_skip_relocation
#    sha256 "c75434193dbeef5aa056672149fd5e11e9ec7ddc72f4d139658370cef1657f37" => :sierra
#    sha256 "1568c4630728384e2b95510e313090f788478ff39f873ab7c83b43be94864691" => :el_capitan
#    sha256 "57eb0506413dc457a71d2246f4b22a83f4e9e92208003ff92f1fffd5b6384e4c" => :yosemite
#  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    arch = MacOS.prefer_64_bit? ? "amd64" : "x86"
    dir = buildpath/"src/ksonnet/kubecfg"
    dir.install buildpath.children - [buildpath/".brew_home"]

    cd dir do
      # get deps
      system "go", "get"
      # Make binary
      system "make", "kubecfg"
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
