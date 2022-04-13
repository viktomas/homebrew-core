class Maxima < Formula
  desc "Computer algebra system"
  homepage "https://maxima.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/maxima/Maxima-source/5.46.0-source/maxima-5.46.0.tar.gz"
  sha256 "7390f06b48da65c9033e8b2f629b978b90056454a54022db7de70e2225aa8b07"
  license "GPL-2.0-only"

  livecheck do
    url :stable
    regex(%r{url=.*?/maxima[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_monterey: "5c06a235975a72dd1f3441420f3f962aa5d2ff388634bf69f9898d8d30e5d035"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "f2b30807d9dc4138ad48a027c721d0f2efac636ba244abf81b76e3697e3c0482"
    sha256 cellar: :any_skip_relocation, monterey:       "431234378019407a587e8b794f40cc58e6eea474a27d2cf1d7067cfc2a7ea116"
    sha256 cellar: :any_skip_relocation, big_sur:        "7eb3ed75bfe3a2786dc959724c99769c123e9fcc9ac2293ad887c2c280d7e974"
    sha256 cellar: :any_skip_relocation, catalina:       "ffb175c92077e3d87cc659bc888113d656c37a0c3cb75d479a385627a9cd2ce0"
    sha256 cellar: :any_skip_relocation, mojave:         "0d18434459d1c811395e78b2c08ad797332fd34b0d35fe22aa4f409ae6e3500b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "618501ffc053e46a7501dab5aa12e7ab8bc3e0bd27110b98b04236e8fcc418ed"
  end

  depends_on "gawk" => :build
  depends_on "gnu-sed" => :build
  depends_on "perl" => :build
  depends_on "texinfo" => :build
  depends_on "gettext"
  depends_on "gnuplot"
  depends_on "rlwrap"
  depends_on "sbcl"

  def install
    ENV["LANG"] = "C" # per build instructions
    system "./configure",
           "--disable-debug",
           "--disable-dependency-tracking",
           "--prefix=#{prefix}",
           "--enable-gettext",
           "--enable-sbcl",
           "--with-emacs-prefix=#{share}/emacs/site-lisp/#{name}",
           "--with-sbcl=#{Formula["sbcl"].opt_bin}/sbcl"
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/maxima", "--batch-string=run_testsuite(); quit();"
  end
end
