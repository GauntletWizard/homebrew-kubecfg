class Ksonnetlib < Formula
  desc "Standard library for kubecfg"
  homepage "http://ksonnet.heptio.com/"
  url "https://github.com/ksonnet/ksonnet-lib.git",
    :tag => "beta.2",
    :revision => "9f6e7b23e20dc0721cec8f5933e4f8692c5a30b6"
  head "https://github.com/ksonnet/ksonnet-lib.git"

  def install
    libdir = (share/"ksonnet-lib")
    libdir.mkpath
    libdir.install "ksonnet.alpha.1"
    libdir.install "ksonnet.beta.1"
    libdir.install "ksonnet.beta.2"
  end

  def caveats
    libdir = (share/"ksonnet-lib")
    s = <<-EOS.undent
      Libraries have been made available at #{libdir}
      Add the following to your .bash_profile:

      export KUBECFG_JPATH="#{libdir}"
    EOS
    s
  end

  test do
    run_output = shell_output("#{bin}/kubecf 2>&1")
    assert_match "Synchronise Kubernetes resources with config files", run_output
  end
end
