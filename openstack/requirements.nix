# generated using pypi2nix tool (version: 2.0.2)
# See more at: https://github.com/nix-community/pypi2nix
#
# COMMAND:
#   pypi2nix -e python-openstackclient -v -E openssl -E libffi
#

{ pkgs ? import <nixpkgs> {},
  overrides ? ({ pkgs, python }: self: super: {})
}:

let

  inherit (pkgs) makeWrapper;
  inherit (pkgs.stdenv.lib) fix' extends inNixShell;

  pythonPackages =
  import "${toString pkgs.path}/pkgs/top-level/python-packages.nix" {
    inherit pkgs;
    inherit (pkgs) stdenv;
    python = pkgs.python3;
  };

  commonBuildInputs = with pkgs; [ openssl libffi ];
  commonDoCheck = false;

  withPackages = pkgs':
    let
      pkgs = builtins.removeAttrs pkgs' ["__unfix__"];
      interpreterWithPackages = selectPkgsFn: pythonPackages.buildPythonPackage {
        name = "python3-interpreter";
        buildInputs = [ makeWrapper ] ++ (selectPkgsFn pkgs);
        buildCommand = ''
          mkdir -p $out/bin
          ln -s ${pythonPackages.python.interpreter} \
              $out/bin/${pythonPackages.python.executable}
          for dep in ${builtins.concatStringsSep " "
              (selectPkgsFn pkgs)}; do
            if [ -d "$dep/bin" ]; then
              for prog in "$dep/bin/"*; do
                if [ -x "$prog" ] && [ -f "$prog" ]; then
                  ln -s $prog $out/bin/`basename $prog`
                fi
              done
            fi
          done
          for prog in "$out/bin/"*; do
            wrapProgram "$prog" --prefix PYTHONPATH : "$PYTHONPATH"
          done
          pushd $out/bin
          ln -s ${pythonPackages.python.executable} python
          ln -s ${pythonPackages.python.executable} \
              python3
          popd
        '';
        passthru.interpreter = pythonPackages.python;
      };

      interpreter = interpreterWithPackages builtins.attrValues;
    in {
      __old = pythonPackages;
      inherit interpreter;
      inherit interpreterWithPackages;
      mkDerivation = args: pythonPackages.buildPythonPackage (args // {
        nativeBuildInputs = (args.nativeBuildInputs or []) ++ args.buildInputs;
      });
      packages = pkgs;
      overrideDerivation = drv: f:
        pythonPackages.buildPythonPackage (
          drv.drvAttrs // f drv.drvAttrs // { meta = drv.meta; }
        );
      withPackages = pkgs'':
        withPackages (pkgs // pkgs'');
    };

  python = withPackages {};

  generated = self: {
    "appdirs" = python.mkDerivation {
      name = "appdirs-1.4.3";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/48/69/d87c60746b393309ca30761f8e2b49473d43450b150cb08f3c6df5c11be5/appdirs-1.4.3.tar.gz";
        sha256 = "9e5896d1372858f8dd3344faf4e5014d21849c756c8d5701f78f8a103b372d92";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/ActiveState/appdirs";
        license = licenses.mit;
        description = "A small Python module for determining appropriate platform-specific dirs, e.g. a \"user data dir\".";
      };
    };

    "attrs" = python.mkDerivation {
      name = "attrs-19.3.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/98/c3/2c227e66b5e896e15ccdae2e00bbc69aa46e9a8ce8869cc5fa96310bf612/attrs-19.3.0.tar.gz";
        sha256 = "f7b7ce16570fe9965acd6d30101a28f62fb4a7f9e926b3bbc9b61f8b04247e72";
};
      doCheck = commonDoCheck;
      format = "pyproject";
      buildInputs = commonBuildInputs ++ [
        self."setuptools"
        self."wheel"
      ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://www.attrs.org/";
        license = licenses.mit;
        description = "Classes Without Boilerplate";
      };
    };

    "babel" = python.mkDerivation {
      name = "babel-2.8.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/34/18/8706cfa5b2c73f5a549fdc0ef2e24db71812a2685959cff31cbdfc010136/Babel-2.8.0.tar.gz";
        sha256 = "1aac2ae2d0d8ea368fa90906567f5c08463d98ade155c0c4bfedd6a0f7160e38";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."pytz"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://babel.pocoo.org/";
        license = licenses.bsdOriginal;
        description = "Internationalization utilities";
      };
    };

    "certifi" = python.mkDerivation {
      name = "certifi-2019.11.28";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/41/bf/9d214a5af07debc6acf7f3f257265618f1db242a3f8e49a9b516f24523a6/certifi-2019.11.28.tar.gz";
        sha256 = "25b64c7da4cd7479594d035c08c2d809eb4aab3a26e5a990ea98cc450c320f1f";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://certifi.io/";
        license = licenses.mpl20;
        description = "Python package for providing Mozilla's CA Bundle.";
      };
    };

    "cffi" = python.mkDerivation {
      name = "cffi-1.13.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/2d/bf/960e5a422db3ac1a5e612cb35ca436c3fc985ed4b7ed13a1b4879006f450/cffi-1.13.2.tar.gz";
        sha256 = "599a1e8ff057ac530c9ad1778293c665cb81a791421f46922d80a86473c13346";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."pycparser"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://cffi.readthedocs.org";
        license = licenses.mit;
        description = "Foreign Function Interface for Python calling C code.";
      };
    };

    "chardet" = python.mkDerivation {
      name = "chardet-3.0.4";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/fc/bb/a5768c230f9ddb03acc9ef3f0d4a3cf93462473795d18e9535498c8f929d/chardet-3.0.4.tar.gz";
        sha256 = "84ab92ed1c4d4f16916e05906b6b75a6c0fb5db821cc65e70cbd64a3e2a5eaae";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/chardet/chardet";
        license = licenses.lgpl2;
        description = "Universal encoding detector for Python 2 and 3";
      };
    };

    "cliff" = python.mkDerivation {
      name = "cliff-2.18.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/4f/45/347101de0cd2b29c941552cbe380021b4de341f8c3c7f4d5debb96a10e78/cliff-2.18.0.tar.gz";
        sha256 = "4893742290d4728324a164c4f4dfeafe5f7ec61a6b49c99d76cece98730667f2";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."cmd2"
        self."pbr"
        self."prettytable"
        self."pyparsing"
        self."pyyaml"
        self."six"
        self."stevedore"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://docs.openstack.org/cliff/latest/";
        license = licenses.asl20;
        description = "Command Line Interface Formulation Framework";
      };
    };

    "cmd2" = python.mkDerivation {
      name = "cmd2-0.8.9";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/21/48/d48fe56f794e9a3feef440e4fb5c80dd4309575e13e132265fc160e82033/cmd2-0.8.9.tar.gz";
        sha256 = "145cb677ebd0e3cae546ab81c30f6c25e0b08ba0f1071df854d53707ea792633";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."pyparsing"
        self."pyperclip"
        self."six"
        self."wcwidth"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/python-cmd2/cmd2";
        license = licenses.mit;
        description = "cmd2 - a tool for building interactive command line applications in Python";
      };
    };

    "cryptography" = python.mkDerivation {
      name = "cryptography-2.8";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/be/60/da377e1bed002716fb2d5d1d1cab720f298cb33ecff7bf7adea72788e4e4/cryptography-2.8.tar.gz";
        sha256 = "3cda1f0ed8747339bbdf71b9f38ca74c7b592f24f65cdb3ab3765e4b02871651";
};
      doCheck = commonDoCheck;
      format = "pyproject";
      buildInputs = commonBuildInputs ++ [
        self."cffi"
        self."setuptools"
        self."wheel"
      ];
      propagatedBuildInputs = [
        self."cffi"
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pyca/cryptography";
        license = licenses.asl20;
        description = "cryptography is a package which provides cryptographic recipes and primitives to Python developers.";
      };
    };

    "debtcollector" = python.mkDerivation {
      name = "debtcollector-1.22.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/c5/2a/686898a291a9f4d40aaf121c0e686498032dda78367d7d3e56079b05abaf/debtcollector-1.22.0.tar.gz";
        sha256 = "d1756440d25a50e3eca2fc399c9e5f1ca2f9e6b837570a80b9450999f4290525";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."pbr"
        self."six"
        self."wrapt"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://docs.openstack.org/debtcollector/latest";
        license = licenses.asl20;
        description = "A collection of Python deprecation patterns and strategies that help you collect your technical debt in a non-destructive manner.";
      };
    };

    "decorator" = python.mkDerivation {
      name = "decorator-4.4.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/dc/c3/9d378af09f5737cfd524b844cd2fbb0d2263a35c11d712043daab290144d/decorator-4.4.1.tar.gz";
        sha256 = "54c38050039232e1db4ad7375cfce6748d7b41c29e95a081c8a6d2c30364a2ce";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/micheles/decorator";
        license = licenses.bsdOriginal;
        description = "Decorators for Humans";
      };
    };

    "dogpile-cache" = python.mkDerivation {
      name = "dogpile-cache-0.9.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/ac/6a/9ac405686a94b7f009a20a50070a5786b0e1aedc707b88d40d0c4b51a82e/dogpile.cache-0.9.0.tar.gz";
        sha256 = "b348835825c9dcd251d9aad1f89f257277ac198a3e35a61980ab4cb28c75216b";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."decorator"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/sqlalchemy/dogpile.cache";
        license = licenses.bsdOriginal;
        description = "A caching front-end based on the Dogpile lock.";
      };
    };

    "idna" = python.mkDerivation {
      name = "idna-2.8";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/ad/13/eb56951b6f7950cadb579ca166e448ba77f9d24efc03edd7e55fa57d04b7/idna-2.8.tar.gz";
        sha256 = "c357b3f628cf53ae2c4c05627ecc484553142ca23264e593d327bcde5e9c3407";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/kjd/idna";
        license = licenses.bsdOriginal;
        description = "Internationalized Domain Names in Applications (IDNA)";
      };
    };

    "importlib-metadata" = python.mkDerivation {
      name = "importlib-metadata-1.4.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/8c/0e/10e247f40c89ba72b7f2a2104ccf1b65de18f79562ffe11bfb837b711acf/importlib_metadata-1.4.0.tar.gz";
        sha256 = "f17c015735e1a88296994c0697ecea7e11db24290941983b08c9feb30921e6d8";
};
      doCheck = commonDoCheck;
      format = "pyproject";
      buildInputs = commonBuildInputs ++ [
        self."setuptools"
        self."setuptools-scm"
        self."wheel"
      ];
      propagatedBuildInputs = [
        self."zipp"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://importlib-metadata.readthedocs.io/";
        license = licenses.asl20;
        description = "Read metadata from Python packages";
      };
    };

    "iso8601" = python.mkDerivation {
      name = "iso8601-0.1.12";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/45/13/3db24895497345fb44c4248c08b16da34a9eb02643cea2754b21b5ed08b0/iso8601-0.1.12.tar.gz";
        sha256 = "49c4b20e1f38aa5cf109ddcd39647ac419f928512c869dc01d5c7098eddede82";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://bitbucket.org/micktwomey/pyiso8601";
        license = licenses.mit;
        description = "Simple module to parse ISO 8601 dates";
      };
    };

    "jmespath" = python.mkDerivation {
      name = "jmespath-0.9.4";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/2c/30/f0162d3d83e398c7a3b70c91eef61d409dea205fb4dc2b47d335f429de32/jmespath-0.9.4.tar.gz";
        sha256 = "bde2aef6f44302dfb30320115b17d030798de8c4110e28d5cf6cf91a7a31074c";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/jmespath/jmespath.py";
        license = licenses.mit;
        description = "JSON Matching Expressions";
      };
    };

    "jsonpatch" = python.mkDerivation {
      name = "jsonpatch-1.24";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/30/ac/9b6478a560627e4310130a9e35c31a9f4d650704bbd03946e77c73abcf6c/jsonpatch-1.24.tar.gz";
        sha256 = "cbb72f8bf35260628aea6b508a107245f757d1ec839a19c34349985e2c05645a";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."jsonpointer"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/stefankoegl/python-json-patch";
        license = licenses.bsdOriginal;
        description = "Apply JSON-Patches (RFC 6902) ";
      };
    };

    "jsonpointer" = python.mkDerivation {
      name = "jsonpointer-2.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/52/e7/246d9ef2366d430f0ce7bdc494ea2df8b49d7a2a41ba51f5655f68cfe85f/jsonpointer-2.0.tar.gz";
        sha256 = "c192ba86648e05fdae4f08a17ec25180a9aef5008d973407b581798a83975362";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/stefankoegl/python-json-pointer";
        license = licenses.bsdOriginal;
        description = "Identify specific nodes in a JSON document (RFC 6901) ";
      };
    };

    "jsonschema" = python.mkDerivation {
      name = "jsonschema-3.2.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/69/11/a69e2a3c01b324a77d3a7c0570faa372e8448b666300c4117a516f8b1212/jsonschema-3.2.0.tar.gz";
        sha256 = "c8a85b28d377cc7737e46e2d9f2b4f44ee3c0e1deac6bf46ddefc7187d30797a";
};
      doCheck = commonDoCheck;
      format = "pyproject";
      buildInputs = commonBuildInputs ++ [
        self."setuptools"
        self."setuptools-scm"
        self."wheel"
      ];
      propagatedBuildInputs = [
        self."attrs"
        self."importlib-metadata"
        self."pyrsistent"
        self."setuptools"
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/Julian/jsonschema";
        license = licenses.mit;
        description = "An implementation of JSON Schema validation for Python";
      };
    };

    "keystoneauth1" = python.mkDerivation {
      name = "keystoneauth1-3.18.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/9e/36/afc5ff283a790784941c7f180398193b84694a1f5172c396cc69dc42c29e/keystoneauth1-3.18.0.tar.gz";
        sha256 = "3ae67c6542ed66a37cddcd26a35457c1ff5cd14b20f5490973273cf9eb555a52";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."iso8601"
        self."os-service-types"
        self."pbr"
        self."requests"
        self."six"
        self."stevedore"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://docs.openstack.org/keystoneauth/latest/";
        license = licenses.asl20;
        description = "Authentication Library for OpenStack Identity";
      };
    };

    "more-itertools" = python.mkDerivation {
      name = "more-itertools-8.1.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/df/8c/c278395367a46c00d28036143fdc6583db8f98622b83875403f16473509b/more-itertools-8.1.0.tar.gz";
        sha256 = "c468adec578380b6281a114cb8a5db34eb1116277da92d7c46f904f0b52d3288";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/erikrose/more-itertools";
        license = licenses.mit;
        description = "More routines for operating on iterables, beyond itertools";
      };
    };

    "msgpack" = python.mkDerivation {
      name = "msgpack-0.6.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/74/0a/de673c1c987f5779b65ef69052331ec0b0ebd22958bda77a8284be831964/msgpack-0.6.2.tar.gz";
        sha256 = "ea3c2f859346fcd55fc46e96885301d9c2f7a36d453f5d8f2967840efa1e1830";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://msgpack.org/";
        license = licenses.asl20;
        description = "MessagePack (de)serializer.";
      };
    };

    "munch" = python.mkDerivation {
      name = "munch-2.5.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/43/a1/ec48010724eedfe2add68eb7592a0d238590e14e08b95a4ffb3c7b2f0808/munch-2.5.0.tar.gz";
        sha256 = "2d735f6f24d4dba3417fa448cae40c6e896ec1fdab6cdb5e6510999758a4dbd2";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/Infinidat/munch";
        license = licenses.mit;
        description = "A dot-accessible dictionary (a la JavaScript objects)";
      };
    };

    "netaddr" = python.mkDerivation {
      name = "netaddr-0.7.19";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/0c/13/7cbb180b52201c07c796243eeff4c256b053656da5cfe3916c3f5b57b3a0/netaddr-0.7.19.tar.gz";
        sha256 = "38aeec7cdd035081d3a4c306394b19d677623bf76fa0913f6695127c7753aefd";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/drkjam/netaddr/";
        license = licenses.bsdOriginal;
        description = "A network address manipulation library for Python";
      };
    };

    "netifaces" = python.mkDerivation {
      name = "netifaces-0.10.9";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/0d/18/fd6e9c71a35b67a73160ec80a49da63d1eed2d2055054cc2995714949132/netifaces-0.10.9.tar.gz";
        sha256 = "2dee9ffdd16292878336a58d04a20f0ffe95555465fee7c9bd23b3490ef2abf3";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/al45tair/netifaces";
        license = licenses.mit;
        description = "Portable network interface information.";
      };
    };

    "openstacksdk" = python.mkDerivation {
      name = "openstacksdk-0.39.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/9e/08/78cba78fed39e5c132bd8d470500423b81950030c318d2cf87ea70adad9e/openstacksdk-0.39.0.tar.gz";
        sha256 = "dd4b22c3d3495805cfe44034945eea3c63acd1dd3d0b429d73dd5b274dfafec0";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."appdirs"
        self."cryptography"
        self."decorator"
        self."dogpile-cache"
        self."iso8601"
        self."jmespath"
        self."jsonpatch"
        self."keystoneauth1"
        self."munch"
        self."netifaces"
        self."os-service-types"
        self."pbr"
        self."pyyaml"
        self."requestsexceptions"
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://docs.openstack.org/openstacksdk/";
        license = licenses.asl20;
        description = "An SDK for building applications to work with OpenStack";
      };
    };

    "os-service-types" = python.mkDerivation {
      name = "os-service-types-1.7.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/58/3f/09e93eb484b69d2a0d31361962fb667591a850630c8ce47bb177324910ec/os-service-types-1.7.0.tar.gz";
        sha256 = "31800299a82239363995b91f1ebf9106ac7758542a1e4ef6dc737a5932878c6c";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."pbr"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://docs.openstack.org/os-service-types/latest/";
        license = licenses.asl20;
        description = "Python library for consuming OpenStack sevice-types-authority data";
      };
    };

    "osc-lib" = python.mkDerivation {
      name = "osc-lib-2.0.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/a7/d3/00d5b716ca5e5de8ef43a9eb78e8a9793e8497545e6ab9788e5817dfb8a7/osc-lib-2.0.0.tar.gz";
        sha256 = "b1cd4467b72a73f7a4de51789581f63de6b93f0e0d15e916191aa26234b01ffa";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."babel"
        self."cliff"
        self."keystoneauth1"
        self."openstacksdk"
        self."oslo-i18n"
        self."oslo-utils"
        self."pbr"
        self."simplejson"
        self."six"
        self."stevedore"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://docs.openstack.org/osc-lib/latest/";
        license = licenses.asl20;
        description = "OpenStackClient Library";
      };
    };

    "oslo-config" = python.mkDerivation {
      name = "oslo-config-7.0.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/34/88/00563aad3b258af53c9693e8d9018aa19920febcbb81d0166b100b1c54af/oslo.config-7.0.0.tar.gz";
        sha256 = "77a3104b1aa70d97adcc93513fcc61df5067a00152d429b9f5f7dcca214f11b4";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."debtcollector"
        self."netaddr"
        self."oslo-i18n"
        self."pyyaml"
        self."requests"
        self."rfc3986"
        self."six"
        self."stevedore"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://docs.openstack.org/oslo.config/latest/";
        license = licenses.asl20;
        description = "Oslo Configuration API";
      };
    };

    "oslo-i18n" = python.mkDerivation {
      name = "oslo-i18n-3.25.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/57/50/ec34f401c3d4cd54632faa24edc3b08336eed763fceb6bc0d51acf683059/oslo.i18n-3.25.1.tar.gz";
        sha256 = "8479724031bee200cb72577cf9670c48c93089e32627a74fb3dc80dec2812fc9";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."babel"
        self."pbr"
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://docs.openstack.org/oslo.i18n/latest";
        license = licenses.asl20;
        description = "Oslo i18n library";
      };
    };

    "oslo-serialization" = python.mkDerivation {
      name = "oslo-serialization-2.29.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/0d/7b/3405bd8b9c7d8246ed60a31fa2c7b41f4891aff67d0db424833043de9723/oslo.serialization-2.29.2.tar.gz";
        sha256 = "f1571f477be946fbb5ee80a939db51a9fb8f1da7902a7dfe0c8b3b2657e8469e";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."msgpack"
        self."oslo-utils"
        self."pbr"
        self."pytz"
        self."pyyaml"
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://docs.openstack.org/oslo.serialization/latest/";
        license = licenses.asl20;
        description = "Oslo Serialization library";
      };
    };

    "oslo-utils" = python.mkDerivation {
      name = "oslo-utils-3.42.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/01/26/ef611501bb2429a36675539256acf06ea630d158553e86e8991f805f5264/oslo.utils-3.42.1.tar.gz";
        sha256 = "c9f35cc64a28a043dd8dd60e35586e840e188b6f165d08f5da55ef234c034ef2";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."debtcollector"
        self."iso8601"
        self."netaddr"
        self."netifaces"
        self."oslo-i18n"
        self."pbr"
        self."pyparsing"
        self."pytz"
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://docs.openstack.org/oslo.utils/latest/";
        license = licenses.asl20;
        description = "Oslo Utility library";
      };
    };

    "pbr" = python.mkDerivation {
      name = "pbr-5.4.4";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/98/8a/defa5215d2dcf98cc80f4783e951a8356e38f352f7a169ae11670dcb1f25/pbr-5.4.4.tar.gz";
        sha256 = "139d2625547dbfa5fb0b81daebb39601c478c21956dc57e2e07b74450a8c506b";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://docs.openstack.org/pbr/latest/";
        license = licenses.asl20;
        description = "Python Build Reasonableness";
      };
    };

    "prettytable" = python.mkDerivation {
      name = "prettytable-0.7.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/23/4a/9785a37ed6425918af69909af715ced0fa261e518601a0c70309a708fd08/prettytable-0.7.2.zip";
        sha256 = "a53da3b43d7a5c229b5e3ca2892ef982c46b7923b51e98f0db49956531211c4f";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://code.google.com/p/prettytable";
        license = licenses.bsdOriginal;
        description = "A simple Python library for easily displaying tabular data in a visually appealing ASCII table format";
      };
    };

    "pycparser" = python.mkDerivation {
      name = "pycparser-2.19";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/68/9e/49196946aee219aead1290e00d1e7fdeab8567783e83e1b9ab5585e6206a/pycparser-2.19.tar.gz";
        sha256 = "a988718abfad80b6b157acce7bf130a30876d27603738ac39f140993246b25b3";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/eliben/pycparser";
        license = licenses.bsdOriginal;
        description = "C parser in Python";
      };
    };

    "pyopenssl" = python.mkDerivation {
      name = "pyopenssl-19.1.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/0d/1d/6cc4bd4e79f78be6640fab268555a11af48474fac9df187c3361a1d1d2f0/pyOpenSSL-19.1.0.tar.gz";
        sha256 = "9a24494b2602aaf402be5c9e30a0b82d4a5c67528fe8fb475e3f3bc00dd69507";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."cryptography"
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pyopenssl.org/";
        license = licenses.asl20;
        description = "Python wrapper module around the OpenSSL library";
      };
    };

    "pyparsing" = python.mkDerivation {
      name = "pyparsing-2.4.6";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/a2/56/0404c03c83cfcca229071d3c921d7d79ed385060bbe969fde3fd8f774ebd/pyparsing-2.4.6.tar.gz";
        sha256 = "4c830582a84fb022400b85429791bc551f1f4871c33f23e44f353119e92f969f";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pyparsing/pyparsing/";
        license = licenses.mit;
        description = "Python parsing module";
      };
    };

    "pyperclip" = python.mkDerivation {
      name = "pyperclip-1.7.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/2d/0f/4eda562dffd085945d57c2d9a5da745cfb5228c02bc90f2c74bbac746243/pyperclip-1.7.0.tar.gz";
        sha256 = "979325468ccf682104d5dcaf753f869868100631301d3e72f47babdea5700d1c";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/asweigart/pyperclip";
        license = licenses.bsdOriginal;
        description = "A cross-platform clipboard module for Python. (Only handles plain text for now.)";
      };
    };

    "pyrsistent" = python.mkDerivation {
      name = "pyrsistent-0.15.7";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/90/aa/cdcf7ef88cc0f831b6f14c8c57318824c9de9913fe8de38e46a98c069a35/pyrsistent-0.15.7.tar.gz";
        sha256 = "cdc7b5e3ed77bed61270a47d35434a30617b9becdf2478af76ad2c6ade307280";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/tobgu/pyrsistent/";
        license = licenses.mit;
        description = "Persistent/Functional/Immutable data structures";
      };
    };

    "python-cinderclient" = python.mkDerivation {
      name = "python-cinderclient-5.0.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/6c/b1/5e23c47d3fedf48f9962ed7f0441ab3a938f1f51cd179c7352c316cc9249/python-cinderclient-5.0.0.tar.gz";
        sha256 = "d61bc8d816c1fe18304843b70bbb33220ebb5ae554b4c3a1c83486ad0d7d1509";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."babel"
        self."keystoneauth1"
        self."oslo-i18n"
        self."oslo-utils"
        self."pbr"
        self."prettytable"
        self."requests"
        self."simplejson"
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://docs.openstack.org/python-cinderclient/latest/";
        license = licenses.asl20;
        description = "OpenStack Block Storage API Client Library";
      };
    };

    "python-glanceclient" = python.mkDerivation {
      name = "python-glanceclient-2.17.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/96/71/76feb61e7a6e0aee71dcba8372fbf52f32a453bfcfc645df138076ddf24c/python-glanceclient-2.17.0.tar.gz";
        sha256 = "cb9d1168aa4857800069419b0114756cb78fea5f1c38ae1d78a2851e49561142";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."keystoneauth1"
        self."oslo-i18n"
        self."oslo-utils"
        self."pbr"
        self."prettytable"
        self."pyopenssl"
        self."requests"
        self."six"
        self."warlock"
        self."wrapt"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://docs.openstack.org/python-glanceclient/latest/";
        license = licenses.asl20;
        description = "OpenStack Image API Client Library";
      };
    };

    "python-keystoneclient" = python.mkDerivation {
      name = "python-keystoneclient-3.22.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/f8/f6/c54a3e0ce02dac89f23b35ef73f17f803dda02051030f95b2cfa77a9b134/python-keystoneclient-3.22.0.tar.gz";
        sha256 = "6e2b6d2a5ae5d7aa26d4e52d1c682e08417d2c5d73ccc54cb65c54903a868cb4";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."debtcollector"
        self."keystoneauth1"
        self."oslo-config"
        self."oslo-i18n"
        self."oslo-serialization"
        self."oslo-utils"
        self."pbr"
        self."requests"
        self."six"
        self."stevedore"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://docs.openstack.org/python-keystoneclient/latest/";
        license = licenses.asl20;
        description = "Client Library for OpenStack Identity";
      };
    };

    "python-novaclient" = python.mkDerivation {
      name = "python-novaclient-16.0.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/5c/06/a30900b5804d489ac3357269d58ad3733092bf8d132c9f1a5814272c5276/python-novaclient-16.0.0.tar.gz";
        sha256 = "652e67e7cb3eb423925eef11530638d1b9566757bf90e4e631c6135ce5b972f1";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."babel"
        self."iso8601"
        self."keystoneauth1"
        self."oslo-i18n"
        self."oslo-serialization"
        self."oslo-utils"
        self."pbr"
        self."prettytable"
        self."simplejson"
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://docs.openstack.org/python-novaclient/latest";
        license = licenses.asl20;
        description = "Client library for OpenStack Compute API";
      };
    };

    "python-openstackclient" = python.mkDerivation {
      name = "python-openstackclient-4.0.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/e2/5b/b3afe89d8bf4c8c9f6a79e7163375eaae450cde4305e2eda51cf462fe548/python-openstackclient-4.0.0.tar.gz";
        sha256 = "3b11c423a38074b0b58ba66d5f6e5334759f50e99fe19c3dfc662a6299dc2e16";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."babel"
        self."cliff"
        self."keystoneauth1"
        self."openstacksdk"
        self."osc-lib"
        self."oslo-i18n"
        self."oslo-utils"
        self."pbr"
        self."python-cinderclient"
        self."python-glanceclient"
        self."python-keystoneclient"
        self."python-novaclient"
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://docs.openstack.org/python-openstackclient/latest/";
        license = licenses.asl20;
        description = "OpenStack Command-line Client";
      };
    };

    "pytz" = python.mkDerivation {
      name = "pytz-2019.3";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/82/c3/534ddba230bd4fbbd3b7a3d35f3341d014cca213f369a9940925e7e5f691/pytz-2019.3.tar.gz";
        sha256 = "b02c06db6cf09c12dd25137e563b31700d3b80fcc4ad23abb7a315f2789819be";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pythonhosted.org/pytz";
        license = licenses.mit;
        description = "World timezone definitions, modern and historical";
      };
    };

    "pyyaml" = python.mkDerivation {
      name = "pyyaml-5.3";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/3d/d9/ea9816aea31beeadccd03f1f8b625ecf8f645bd66744484d162d84803ce5/PyYAML-5.3.tar.gz";
        sha256 = "e9f45bd5b92c7974e59bcd2dcc8631a6b6cc380a904725fce7bc08872e691615";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/yaml/pyyaml";
        license = licenses.mit;
        description = "YAML parser and emitter for Python";
      };
    };

    "requests" = python.mkDerivation {
      name = "requests-2.22.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/01/62/ddcf76d1d19885e8579acb1b1df26a852b03472c0e46d2b959a714c90608/requests-2.22.0.tar.gz";
        sha256 = "11e007a8a2aa0323f5a921e9e6a2d7e4e67d9877e85773fba9ba6419025cbeb4";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."certifi"
        self."chardet"
        self."idna"
        self."urllib3"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://python-requests.org";
        license = licenses.asl20;
        description = "Python HTTP for Humans.";
      };
    };

    "requestsexceptions" = python.mkDerivation {
      name = "requestsexceptions-1.4.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/82/ed/61b9652d3256503c99b0b8f145d9c8aa24c514caff6efc229989505937c1/requestsexceptions-1.4.0.tar.gz";
        sha256 = "b095cbc77618f066d459a02b137b020c37da9f46d9b057704019c9f77dba3065";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://www.openstack.org/";
        license = licenses.asl20;
        description = "Import exceptions from potentially bundled packages in requests.";
      };
    };

    "rfc3986" = python.mkDerivation {
      name = "rfc3986-1.3.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/34/c9/bcba83f13f628e947e23a0e54e18d0a6f13e5d03ca4ec04def0105c81bfc/rfc3986-1.3.2.tar.gz";
        sha256 = "0344d0bd428126ce554e7ca2b61787b6a28d2bbd19fc70ed2dd85efe31176405";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://rfc3986.readthedocs.io";
        license = licenses.asl20;
        description = "Validating URI References per RFC 3986";
      };
    };

    "setuptools" = python.mkDerivation {
      name = "setuptools-45.0.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/fd/76/3c7f726ed5c582019937f178d7478ce62716b7e8263344f1684cbe11ab3e/setuptools-45.0.0.zip";
        sha256 = "c46d9c8f2289535457d36c676b541ca78f7dcb736b97d02f50d17f7f15b583cc";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pypa/setuptools";
        license = licenses.mit;
        description = "Easily download, build, install, upgrade, and uninstall Python packages";
      };
    };

    "setuptools-scm" = python.mkDerivation {
      name = "setuptools-scm-3.3.3";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/83/44/53cad68ce686585d12222e6769682c4bdb9686808d2739671f9175e2938b/setuptools_scm-3.3.3.tar.gz";
        sha256 = "bd25e1fb5e4d603dcf490f1fde40fb4c595b357795674c3e5cb7f6217ab39ea5";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pypa/setuptools_scm/";
        license = licenses.mit;
        description = "the blessed package to manage your versions by scm tags";
      };
    };

    "simplejson" = python.mkDerivation {
      name = "simplejson-3.17.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/98/87/a7b98aa9256c8843f92878966dc3d8d914c14aad97e2c5ce4798d5743e07/simplejson-3.17.0.tar.gz";
        sha256 = "2b4b2b738b3b99819a17feaf118265d0753d5536049ea570b3c43b51c4701e81";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/simplejson/simplejson";
        license = licenses.mit;
        description = "Simple, fast, extensible JSON encoder/decoder for Python";
      };
    };

    "six" = python.mkDerivation {
      name = "six-1.14.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/21/9f/b251f7f8a76dec1d6651be194dfba8fb8d7781d10ab3987190de8391d08e/six-1.14.0.tar.gz";
        sha256 = "236bdbdce46e6e6a3d61a337c0f8b763ca1e8717c03b369e87a7ec7ce1319c0a";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/benjaminp/six";
        license = licenses.mit;
        description = "Python 2 and 3 compatibility utilities";
      };
    };

    "stevedore" = python.mkDerivation {
      name = "stevedore-1.31.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/05/79/516aa1c427da04f818242ec147a2f417dd0e8f4abbc9302ed07459fb152d/stevedore-1.31.0.tar.gz";
        sha256 = "e0739f9739a681c7a1fda76a102b65295e96a144ccdb552f2ae03c5f0abe8a14";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."pbr"
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://docs.openstack.org/stevedore/latest/";
        license = licenses.asl20;
        description = "Manage dynamic plugins for Python applications";
      };
    };

    "urllib3" = python.mkDerivation {
      name = "urllib3-1.25.7";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/ad/fc/54d62fa4fc6e675678f9519e677dfc29b8964278d75333cf142892caf015/urllib3-1.25.7.tar.gz";
        sha256 = "f3c5fd51747d450d4dcf6f923c81f78f811aab8205fda64b0aba34a4e48b0745";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://urllib3.readthedocs.io/";
        license = licenses.mit;
        description = "HTTP library with thread-safe connection pooling, file post, and more.";
      };
    };

    "warlock" = python.mkDerivation {
      name = "warlock-1.3.3";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/c2/36/178b26a338cd6d30523246da4721b1114306f588deb813f3f503052825ee/warlock-1.3.3.tar.gz";
        sha256 = "a093c4d04b42b7907f69086e476a766b7639dca50d95edc83aef6aeab9db2090";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."jsonpatch"
        self."jsonschema"
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/bcwaldon/warlock";
        license = "Apache-2.0";
        description = "Python object model built on JSON schema and JSON patch.";
      };
    };

    "wcwidth" = python.mkDerivation {
      name = "wcwidth-0.1.8";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/5e/33/92333eb80be0c96385dee338f30b53e24a8b415d5785e225d789b3f90feb/wcwidth-0.1.8.tar.gz";
        sha256 = "f28b3e8a6483e5d49e7f8949ac1a78314e740333ae305b4ba5defd3e74fb37a8";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/jquast/wcwidth";
        license = licenses.mit;
        description = "Measures number of Terminal column cells of wide-character codes";
      };
    };

    "wheel" = python.mkDerivation {
      name = "wheel-0.33.6";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/59/b0/11710a598e1e148fb7cbf9220fd2a0b82c98e94efbdecb299cb25e7f0b39/wheel-0.33.6.tar.gz";
        sha256 = "10c9da68765315ed98850f8e048347c3eb06dd81822dc2ab1d4fde9dc9702646";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pypa/wheel";
        license = licenses.mit;
        description = "A built-package format for Python.";
      };
    };

    "wrapt" = python.mkDerivation {
      name = "wrapt-1.11.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/23/84/323c2415280bc4fc880ac5050dddfb3c8062c2552b34c2e512eb4aa68f79/wrapt-1.11.2.tar.gz";
        sha256 = "565a021fd19419476b9362b05eeaa094178de64f8361e44468f9e9d7843901e1";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/GrahamDumpleton/wrapt";
        license = licenses.bsdOriginal;
        description = "Module for decorators, wrappers and monkey patching.";
      };
    };

    "zipp" = python.mkDerivation {
      name = "zipp-1.0.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/d4/cd/ef86396dce8910413b6ca1ef31ec09367c47e15fc1a12def2cc8ae134dea/zipp-1.0.0.tar.gz";
        sha256 = "d38fbe01bbf7a3593a32bc35a9c4453c32bc42b98c377f9bff7e9f8da157786c";
};
      doCheck = commonDoCheck;
      format = "pyproject";
      buildInputs = commonBuildInputs ++ [
        self."setuptools"
        self."setuptools-scm"
        self."wheel"
      ];
      propagatedBuildInputs = [
        self."more-itertools"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/jaraco/zipp";
        license = licenses.mit;
        description = "Backport of pathlib-compatible object wrapper for zip files";
      };
    };
  };
  localOverridesFile = ./requirements_override.nix;
  localOverrides = import localOverridesFile { inherit pkgs python; };
  commonOverrides = [
        (let src = pkgs.fetchFromGitHub { owner = "nix-community"; repo = "pypi2nix-overrides"; rev = "db87933d87d9b3943cf636a49f16b76c9ea66db7"; sha256 = "1phiqh72dyg7qhkv15kdg4gjkx8rkywvs41j7liz5faj66ijlpv6"; } ; in import "${src}/overrides.nix" { inherit pkgs python; })
  ];
  paramOverrides = [
    (overrides { inherit pkgs python; })
  ];
  allOverrides =
    (if (builtins.pathExists localOverridesFile)
     then [localOverrides] else [] ) ++ commonOverrides ++ paramOverrides;

in python.withPackages
   (fix' (pkgs.lib.fold
            extends
            generated
            allOverrides
         )
   )