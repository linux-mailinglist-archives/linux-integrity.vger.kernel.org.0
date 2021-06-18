Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3CFC3AD562
	for <lists+linux-integrity@lfdr.de>; Sat, 19 Jun 2021 00:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbhFRWtv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Jun 2021 18:49:51 -0400
Received: from mga14.intel.com ([192.55.52.115]:41708 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231455AbhFRWtu (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Jun 2021 18:49:50 -0400
IronPort-SDR: x3HqriAf0VsZLvnaYs86uiyxhDaly5UO1N+G4CHfARRq+fHWNMhdDCgTyOitap9JeuaXSNB5jy
 fRRahnp7c/lQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="206450955"
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="gz'50?scan'50,208,50";a="206450955"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 15:47:39 -0700
IronPort-SDR: HWeGGkEchcDxp5Itp2V5QEuU9Pj33dAvSuhE4OpeAi6REU1LbT3vxXVCpNI8P9oz4/gZc+JZ1M
 poO/tWXvUL0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="gz'50?scan'50,208,50";a="405105458"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 18 Jun 2021 15:47:36 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1luNGy-0003BG-2E; Fri, 18 Jun 2021 22:47:36 +0000
Date:   Sat, 19 Jun 2021 06:46:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-integrity@vger.kernel.org,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Subject: [integrity:next-integrity-testing 13/13]
 security/integrity/evm/evm_crypto.c:181:41: warning: format specifies type
 'unsigned long' but the argument has type 'unsigned int'
Message-ID: <202106190637.Sg2c2F2k-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity-testing
head:   5b5aed323646d2240eb70913841ef06c94d6e9a5
commit: 5b5aed323646d2240eb70913841ef06c94d6e9a5 [13/13] evm: output EVM digest calculation info
config: riscv-randconfig-r003-20210618 (attached as .config)
compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 64720f57bea6a6bf033feef4a5751ab9c0c3b401)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/commit/?id=5b5aed323646d2240eb70913841ef06c94d6e9a5
        git remote add integrity https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
        git fetch --no-tags integrity next-integrity-testing
        git checkout 5b5aed323646d2240eb70913841ef06c94d6e9a5
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> security/integrity/evm/evm_crypto.c:181:41: warning: format specifies type 'unsigned long' but the argument has type 'unsigned int' [-Wformat]
           pr_debug("hmac_misc: (%lu) [%*phN]\n", sizeof(struct h_misc),
                                 ~~~              ^~~~~~~~~~~~~~~~~~~~~
                                 %u
   include/linux/printk.h:430:38: note: expanded from macro 'pr_debug'
           no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
                                       ~~~     ^~~~~~~~~~~
   include/linux/printk.h:140:17: note: expanded from macro 'no_printk'
                   printk(fmt, ##__VA_ARGS__);             \
                          ~~~    ^~~~~~~~~~~
>> security/integrity/evm/evm_crypto.c:261:7: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
                                            req_xattr_value_len,
                                            ^~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:430:38: note: expanded from macro 'pr_debug'
           no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
                                       ~~~     ^~~~~~~~~~~
   include/linux/printk.h:140:17: note: expanded from macro 'no_printk'
                   printk(fmt, ##__VA_ARGS__);             \
                          ~~~    ^~~~~~~~~~~
   security/integrity/evm/evm_crypto.c:286:47: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
                           pr_debug("%s: (%lu) [%*phN]", xattr->name, xattr_size,
                                          ~~~                         ^~~~~~~~~~
                                          %u
   include/linux/printk.h:430:38: note: expanded from macro 'pr_debug'
           no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
                                       ~~~     ^~~~~~~~~~~
   include/linux/printk.h:140:17: note: expanded from macro 'no_printk'
                   printk(fmt, ##__VA_ARGS__);             \
                          ~~~    ^~~~~~~~~~~
   3 warnings generated.


vim +181 security/integrity/evm/evm_crypto.c

   138	
   139	/* Protect against 'cutting & pasting' security.evm xattr, include inode
   140	 * specific info.
   141	 *
   142	 * (Additional directory/file metadata needs to be added for more complete
   143	 * protection.)
   144	 */
   145	static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
   146				  char type, char *digest)
   147	{
   148		struct h_misc {
   149			unsigned long ino;
   150			__u32 generation;
   151			uid_t uid;
   152			gid_t gid;
   153			umode_t mode;
   154		} hmac_misc;
   155	
   156		memset(&hmac_misc, 0, sizeof(hmac_misc));
   157		/* Don't include the inode or generation number in portable
   158		 * signatures
   159		 */
   160		if (type != EVM_XATTR_PORTABLE_DIGSIG) {
   161			hmac_misc.ino = inode->i_ino;
   162			hmac_misc.generation = inode->i_generation;
   163		}
   164		/* The hmac uid and gid must be encoded in the initial user
   165		 * namespace (not the filesystems user namespace) as encoding
   166		 * them in the filesystems user namespace allows an attack
   167		 * where first they are written in an unprivileged fuse mount
   168		 * of a filesystem and then the system is tricked to mount the
   169		 * filesystem for real on next boot and trust it because
   170		 * everything is signed.
   171		 */
   172		hmac_misc.uid = from_kuid(&init_user_ns, inode->i_uid);
   173		hmac_misc.gid = from_kgid(&init_user_ns, inode->i_gid);
   174		hmac_misc.mode = inode->i_mode;
   175		crypto_shash_update(desc, (const u8 *)&hmac_misc, sizeof(hmac_misc));
   176		if ((evm_hmac_attrs & EVM_ATTR_FSUUID) &&
   177		    type != EVM_XATTR_PORTABLE_DIGSIG)
   178			crypto_shash_update(desc, (u8 *)&inode->i_sb->s_uuid, UUID_SIZE);
   179		crypto_shash_final(desc, digest);
   180	
 > 181		pr_debug("hmac_misc: (%lu) [%*phN]\n", sizeof(struct h_misc),
   182			 (int) sizeof(struct h_misc), &hmac_misc);
   183	}
   184	
   185	/*
   186	 * Dump large security xattr values as a continuous ascii hexademical string.
   187	 * (pr_debug is limited to 64 bytes.)
   188	 */
   189	static void dump_security_xattr(const char *prefix, const void *src, size_t count)
   190	{
   191	#if defined(DEBUG) || defined(CONFIG_DYNAMIC_DEBUG)
   192		char *asciihex, *p;
   193	
   194		p = asciihex = kmalloc(count * 2 + 1, GFP_KERNEL);
   195		if (!asciihex)
   196			return;
   197	
   198		p = bin2hex(p, src, count);
   199		*p = 0;
   200		pr_debug("%s: (%lu) %.*s\n", prefix, count, (int) count * 2, asciihex);
   201		kfree(asciihex);
   202	#endif
   203	}
   204	
   205	/*
   206	 * Calculate the HMAC value across the set of protected security xattrs.
   207	 *
   208	 * Instead of retrieving the requested xattr, for performance, calculate
   209	 * the hmac using the requested xattr value. Don't alloc/free memory for
   210	 * each xattr, but attempt to re-use the previously allocated memory.
   211	 */
   212	static int evm_calc_hmac_or_hash(struct dentry *dentry,
   213					 const char *req_xattr_name,
   214					 const char *req_xattr_value,
   215					 size_t req_xattr_value_len,
   216					 uint8_t type, struct evm_digest *data)
   217	{
   218		struct inode *inode = d_backing_inode(dentry);
   219		struct xattr_list *xattr;
   220		struct shash_desc *desc;
   221		size_t xattr_size = 0;
   222		char *xattr_value = NULL;
   223		int error;
   224		int size;
   225		bool ima_present = false;
   226	
   227		if (!(inode->i_opflags & IOP_XATTR) ||
   228		    inode->i_sb->s_user_ns != &init_user_ns)
   229			return -EOPNOTSUPP;
   230	
   231		desc = init_desc(type, data->hdr.algo);
   232		if (IS_ERR(desc))
   233			return PTR_ERR(desc);
   234	
   235		data->hdr.length = crypto_shash_digestsize(desc->tfm);
   236	
   237		error = -ENODATA;
   238		list_for_each_entry_lockless(xattr, &evm_config_xattrnames, list) {
   239			bool is_ima = false;
   240	
   241			if (strcmp(xattr->name, XATTR_NAME_IMA) == 0)
   242				is_ima = true;
   243	
   244			/*
   245			 * Skip non-enabled xattrs for locally calculated
   246			 * signatures/HMACs.
   247			 */
   248			if (type != EVM_XATTR_PORTABLE_DIGSIG && !xattr->enabled)
   249				continue;
   250	
   251			if ((req_xattr_name && req_xattr_value)
   252			    && !strcmp(xattr->name, req_xattr_name)) {
   253				error = 0;
   254				crypto_shash_update(desc, (const u8 *)req_xattr_value,
   255						     req_xattr_value_len);
   256				if (is_ima)
   257					ima_present = true;
   258	
   259				if (req_xattr_value_len < 64)
   260					pr_debug("%s: (%lu) [%*phN]\n", req_xattr_name,
 > 261						 req_xattr_value_len,
   262						 (int)req_xattr_value_len,
   263						 req_xattr_value);
   264				else
   265					dump_security_xattr(req_xattr_name,
   266							    req_xattr_value,
   267							    req_xattr_value_len);
   268				continue;
   269			}
   270			size = vfs_getxattr_alloc(&init_user_ns, dentry, xattr->name,
   271						  &xattr_value, xattr_size, GFP_NOFS);
   272			if (size == -ENOMEM) {
   273				error = -ENOMEM;
   274				goto out;
   275			}
   276			if (size < 0)
   277				continue;
   278	
   279			error = 0;
   280			xattr_size = size;
   281			crypto_shash_update(desc, (const u8 *)xattr_value, xattr_size);
   282			if (is_ima)
   283				ima_present = true;
   284	
   285			if (xattr_size < 64)
   286				pr_debug("%s: (%lu) [%*phN]", xattr->name, xattr_size,
   287					 (int)xattr_size, xattr_value);
   288			else
   289				dump_security_xattr(xattr->name, xattr_value,
   290						    xattr_size);
   291		}
   292		hmac_add_misc(desc, inode, type, data->digest);
   293	
   294		/* Portable EVM signatures must include an IMA hash */
   295		if (type == EVM_XATTR_PORTABLE_DIGSIG && !ima_present)
   296			error = -EPERM;
   297	out:
   298		kfree(xattr_value);
   299		kfree(desc);
   300		return error;
   301	}
   302	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--GvXjxJ+pjyke8COw
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICBcczWAAAy5jb25maWcAlFxdc9u20r7vr+A0M2famZNGlmwned/xBQSCEiKCYAhQkn3D
UWw50akseyQ5bf792QW/ABJSenqRRruLr8Vi99kFmDe/vAnI6/H5aXXc3K+22x/B1/VuvV8d
1w/B42a7/v8glEEidcBCrv8A4Xize/373X5zuP8eXP1xMfpj8HZ/Pwxm6/1uvQ3o8+5x8/UV
2m+ed7+8+YXKJOKTgtJizjLFZVJottQ3v95vV7uvwff1/gByAfbyxyD47evm+H/v3sGfT5v9
/nn/brv9/lS87J//s74/BteX74eDx6v3X9ar69X1l8fBaPS4Xj9erq7eX12svny8H9yPvlwO
Ln7/tR510g57M7CmwlVBY5JMbn40RPzZyF6MBvBfzSMKG0ySvBUHUi07HF22onHYHw9o0DyO
w7Z5bMm5Y8HkptA5UaKYSC2tCbqMQuY6zbWXz5OYJ6xl8exzsZDZrKXoacYITCuJJPxRaKKQ
Cbv1JpiYzd8Gh/Xx9aXdv3EmZywpYPuUSK2uE64LlswLksGquOD6ZjRspiRFymMGG66sicaS
krhe/K/NVo1zDkpRJNYWMWQRyWNthvGQp1LphAh28+tvu+fdGvb9TVCJqAVJg80h2D0fcSl1
S3Wr5jyl7WwqAv6f6hjoTQ8Loum0+JyznHk6oplUqhBMyOy2IFoTOm07zRWL+bj9PSVzBhqC
7kgOhwjHInFcaxy2Jzi8fjn8OBzXT63GJyxhGadm99RULtrubA6d8tTd6VAKwhOXprjwCRVT
zjKc16091ySEPasEQNbSVUoyxSpaoyd7NiEb55NI2fp6E6x3D8HzY2eZvrUI2FNeTSCzzhoq
joLZzJTMM8pKa+hpw0iwOUu0qjWrN0/gX3zK1ZzOwJgZKNbqKpHF9A7NVsjEXiIQUxhDhpx6
TKFsxWHSdhtDdRVR98Yn0yJjCiYh4Bh4ldWbeds8zRgTqYYBEp9h1uy5jPNEk+zWnlTFtJsZ
RdE0f6dXhz+DI4wbrGAOh+PqeAhW9/fPr7vjZve1ozpoUBBKJQzBbTeK24jLcpnN+GMVwhwk
ZXB2QEJ79ZMq7tXJP5hk2wlOkCsZEw1uprfejOaB8llFclsAz54y/CzYErZf+9xJKWw3V3X7
atbuUI2eZuVf7JFqmtGQZzA+m4LTBouxfSk6zgj8A4/0zcX71gh4omfgTSPWlRl1z42iUxaW
p6c+N+r+2/rhdbveB4/r1fF1vz4YcrUiD9fS+ySTeap8xwQcNXgQ2Ht70blWRaK8doBu+QQL
HGzW4dUr5yEw7BFgeXSWSlAIHjotM+btslQDybU0K/DL3KpIgZODY0SJZqFn/IzFxPKm43gG
8nPjsrLQjZsZEdBb6dMwuLUmFxaTO+6fAvDGwBv6hg6L+E4Qx3jDYnl3StQCF+b3pfP7Tmlr
vmMpddGYbAs5ZAqnnd+xIpIZ+kj4nyAJdTxhV0zBX/yhuYzAzm84e5Sl2uDGjLgdnzyWJpCg
jTi9obKbyFuRozLatIRUKr6sPLNFNefJUkduqYHFEagmszoZEwiTUe4MlAPs7fwEY+1ghJJM
RbqkU3uEVNp9KT5JSByFtueB+doEEwdtgpoCVrFiKrd2n8sizxw3TsI5hyVU6rIUAZ2MSZZx
W7UzFLkVqk8pFYFHQvO5s3XjNKp7P3nADcaLQi8fpsHC0HsCjSLRFAsXDFT5SbrePz7vn1a7
+3XAvq93EEAI+DWKIQRCbhsM3C4a7/cPu6l7mYuyj8KEQ8eoEB4TDcjaMiwVk7GtJxXnY99Z
ATHYi2zCaizsdlFEEOhjrsDlgX1LcYo7JVkIYcCxkzyKAP+lBPqG3QGwDi7TxRAy4pBgTDzz
MkfU+FpHZ25OUQuPhmMbx2Vc0XkH9QlB0iJLwOcBai4EwNoP5/hkacVA01+hxtYZE8KK1nNi
Wln5SlpTLlsKaEFGkWL6ZvA3HZT/OVOIwLjhVEASRMa2IzHMEjGfZrOYUV1nEUKGLO5ILAiY
jonUJC6m+YTpeNztJE9TmcHyc9iZMbMMTEFWMjNbUgtZHsOQAa7B/Ceqz6/RgePpGqhNIL3J
IAKC9TnhrhFQuehTpwsG0NcaJAJXy0gW38LvwvFP6USjvooYDg/4n2aLEKVA/LXmWwKWZwrG
tV3fV0WH9vxICmYDyRrmSeDcY5JF/BQCAFnFI/BUJ9lznmkvNnUnUGPqYL3fr44rZ2qOdbIM
tEjgnIFnSHpOsuL65tRC4v4YZvR0uzqigwqOP17W7bDGYrL5aMjtgSrq9SX3nGlq7BK2J4xN
EtrG9YZBkltfFCbLdHqr0PovJq5XE77cXOcJq22l4xYAypOC1rt9eH15ed5jfSoVeb3AFvOY
BibyINunNk8Hbfso9TdyNWqHFAcktynjxWDgz//uiuHVwBe57orRYNBJPKEXv+zNqPVEja8r
5oMLu4MZWzLqnQXNiJoWYS5S72q7SzNrGz+D2PMLWpkVKKkITb2prc+wiIPzyS1PBRQnhoBd
QGgSFVLiSxZ6Z+EMWNr181+QeEDcXX1dP0HY7U8ntd2IKEsSztgC4Q2C1LBk+rIIAQnRzOmn
dmJlYcTysovP4FcWkI+wKOKUY6zvxeR+e4gqdoQ8uSyz6Gizf/prtV8H4X7z3QEpJBOQuQiO
UVlLKmP3WNdMM79yZK8xlJJp241HJ62M1ZsVUHKAhRCD5bLIFlo4YI+Ky/fLZZHMYcu942vG
inGy1EW08Iw8kXISo5lkYkFsnF0xEHybBEW7MbZigwMCgpJnWU0nPZl5GtaOB6w4+I39fVzv
Dpsv23W7LxxB3+Pqfv075PrGt7RbhIeBKTu2IgWAAQGAHGVSFFHYYWZYORGsWGQkTR3MiNwm
cS9PWBsugIcriCVWCTBb05n0w2sUpSRVOYZYI+5ROwq5pVvIn5kuq50zCKuaT0x5pTN5yofN
TjgjhuDFMainFP4uiPfE/y8qdjRcwQgrqxHLIlSpU2EBkqKOey/rhOuv+1XwWA/1YE6ZXfI4
IVCze+fTqaSv9vffNkcIzuBI3z6sX6CR67ia+X0Cb1wAQGe+89eDdybRmfmpGdPnxLGOH9X5
tJuAJtQk24A9IFXnySdG3S1ua9mm/VTKWYcJW2uMj09ymVsTaOwWFonV0uoWogNn8RIjAmjH
o9u6NtIXQDMsUfMJZgggD5E1SbszVwKBdnX/0FVPxgALQ8ZUQmcsUZpKZS9PN7khCvvopjhV
doDh1ae6dqPPc+3cuSemGMUU8gwLXCYiSwd6lZxTebOZNgYB0J6b9rkcT/tYS1OT7swHLYGB
Z0drmTlFBsP2F4y7W4olljKT5XdeXTiJ4LkkspNAmvyqvk7SMg3lIikbQF4jnfu1GNYGeIXO
IAaFboWxTORNPmsW442eMJo0hSzI5GYA93F3F8vOXD0SfTTRWrqG86S9vZ1hdZvDccA40JcB
Q8ZTljHUB269vWjMxOzShq8Y6+anBmyZlNrUFeqgOqFy/vbL6gBo/M8SdL7snx832/LSob1m
ArFqOadGwjUZsbJEYeoXThnizEiOSeG1cRrnE554yxg/cehNtATVYj3PdsIG7yqBExu0ayt3
wKfBigOnh2GklrPcOu/jqmbf/JxBdFMQgdnn3InbdRV6rCZeYnlZ2eK1pmit2STj2pfc1TJ3
siwfOY2rjKAw1Y/Mi0BQbDH2FW/LntFUItWdbUn1D6oAz8uU+KwD2eWleMESmt2mVUhz2vcE
igi2CQ98Dy+kq/1xg5sdaMgF7dyDQOAybesUw8HjgDGTVsZnxnzZ8u2mUkX+hm3nAtDYz2Q0
yfhPZAShP5NQoVRnlxGHwr8MZJzKudSEO41q2BODlzqhFZWfUGeb/0LW8jOtVHD8jAQ+Erj+
8BMhy+h9UnWi1zEd20TFZ1NgskvzSDYJbflSQLaXb5bVQTsuy/urEACV+/jDYs5ux3bdviaP
o8+2l3MHaSxTJRdW0/KsqJQnRZ6YUOC8FKj45pFJyT/H87ZdgONhpxrbTLe1G3KIBsRAC8gb
PeFPCC4X4ya3+3t9/3pcYc6Br54CU90/Wloe8yQSGqGIle/EUXXzY4GBjBnc18AKBC/Vza3P
N5XdKprx1BfjKz6WmR2P1ZJPdyq4sippOLMKkLbp1olVG5WI9dPz/kcgzhRb/BXstpZWFccF
SXKvZ24L5KWIBWBqjoeEYFTbRcJq/ObC324TAyhLtbEUmkI+ctlpNEY00gkHJakEdvSEk2uZ
Vp0H7wsyhsbnAFnwzVlnYmWGVNRQqPZXylpvbUAGjwqOQSXMbi4HH69riYTB+U0x2U/zYuYU
XWjMIAAROOHemi6xZgIesnq445Z3SXlr6m8PFsqIummuW+5S6Vaf7sa573rubhRJ+yncnUFD
tg5qitnlfvpoMn1wXgaWWp4hrG+trEyjLfqxDFWEPfrWM8nTTqmjOX+pRj/HKCcOljx9Nqwn
QMx3Ng3CZHgB+ok3Fxjh+vvm3lPfK7NK6hZPqa9Mn1JK7BcGKRUwZ7cdUky9p6Bc9VENfXu/
2j8EX/abh68G1bRljM19NbdAdl1AXiYBUxandnRxyLAxeuq8cQDsqEXafSrW5ppJSOLOAyf7
FZPpuy4Ilm8He+tpqjLb59WDqefUXmlRFb3a2TYkY0IhPpixvPwSTKotP7Z17raVyfkbFbT+
zyfgxZW9BuheMqacBKS7oqYEXWaxc9vF13YMJ2lxguenpqL4DPhuluPTzupQtNuW8TkqiVl8
n1uXeHNowfeMTZzTWv4u+JD2aMqutlQ0DNX9xnbcrxtTOu4LjryjFGQubG+L/m4KG2x2P7Kt
A1kRJAbMeoNi54T901Fel7weggdzsJ0qHxbSy9QKr9aLWPgCuL4oSOpmZUha+o6+kEvNLN81
5YrHHH4Usf3U9TOYFDgePrSiIxcpuk3h7paY8orQgv6S1Efv7V2NtdrGrybKLgDCL0AMGbfj
vCEKfKzmYyieRS2nLQYgLx8vK5ZPJ7qp2reQ+2W1P7jIWYewHe8NZneXC4wxFdejZZl6eHNz
kLFBv61AYMnI321NN9ciHwcf/DmWLQgjzCAS+x+8oWSZZxdcgO/SZOLOo2LqbNmdCVp7quL+
Ah0pOBDmcsUj1ctpagUbvefw10A8YyJRPo7R+9XusDUfBgTx6kdvJyDZAZfU3wfEbidWbnhF
ZjmHyH3FncBv31vKJLLfmmVRWDgEpaLQfiUuuv2aDZLpabU1aSD4E0GUdusg5StUIt5lUryL
tqvDt+D+2+alullw3IUxs8h77oHziYWMmqK+u+uAlgoPGTrC0kRVZ1R9ZiLx5Xx3pcgZQ5y9
RTDUeVnfE4z/qeCEScF05n07oFFrKSDxZFYseKinxYU72Q53eJZ72V8ov/DQOr1InXqEwHXH
+AlLX7EiLB9N9lYKgIac8iDAzjWP3e7ANDoE2SGQsQIMZIeiM+ZUpnOrl5fN7mtNxFyvlFrd
g8/unEWEH7BKVCQk+ZOOpZh3HST1EqtyuJ8HisjwKdUH9yWVLRIz69sZm4H7abazfQ5ks2Xk
HxLjZk97NRPvgSAxc+8qbYEJg8SLnz7ltVjKpUnPTuyyVldX7tMO09og8lNOHVLZ0gzapOMn
O1i+hVpvH9/eP++Oq81u/RBAV1VYtpyLNUxINIE0XU1dBTXkqtYCiuLRbXcBrRQclZNKEnSa
Dkez4dX1iaVCfkUycLLcnYNSenjVORgqrnXi7MKphwVmeB2eY5sQMkQ1df1zuDn8+Vbu3lJU
8akMzahB0snIKtrh9yrgXSFzv7m47FP1zWW7pz/fLjOXBDIid1CkdN4dG5+VMOT0YlVJrvax
3NQTu1GLtk+xvD0pIlSeTE7Dl0quYxkeieESQ9Wk7/PIoqjWUsbL1V/vAGGsttv11igkeCxd
HWhv/7zd9vbF9B7CIHHHsixGEeruCg0XX2eELNanjme5Njj7Q29zaVwPnZ5rXeEv//BaeC+6
GgFBsjmL/Y1VTBH6j4bL5dkuWjGPesYZFT5LKpnlk57EHP6zGlomRHl6n6SC15vb5UWASXnU
M7zSfqPriwGgOt8HMu3Clv7GCp/rUi8gbK2CzHlCffail8uPSRgJ6uF9urt8/2HgYUDsZAlW
reipZpeDM8zh1RityLuacsyukfXlIiX8TwBbveTJ8nSMMyKYU14NLs9pDvNLzzKE/eGEtUV9
z1JqGfPis6dGi9GwgG0Y+rplyi6yWuZmCgj94TDK4kcr51dPSYjp/7lpkYwo4hva4MUinjS3
OGJzuPf4KfzD+U6zNUmuZjKpvvTsT65ll4i/uXs8a+b9RqEpNw3OjzAe63OxA8sqtssGy4ZA
9xVCW/3o1rNyv/kDFVKIYkqEcGvpfgGAD36DqsR6x6S+AfHMsOaZoGvWEaeI7f5V/n8YAHAL
nsoKsBdUGTF3yp/Nx9Z1StYM8fOOe+qVnZ4ronmucYl1FHygo/wyapHWz/B61YC+CD4Tm5sr
ldhfie22mzHm/eoai20A8iAV7uwSctC1FMrr0U3fS1Otcx8Q48D5+LTPmt6mLBvnvoJJqC1r
q17hNr8KrGp2i5o2n8Qx9DD2dQxcvO/Cpxr2ANWFhZc1k+NPDqE+hTbNqXPKyLzChNgfVl9M
2LOTAO9icuudfApgQ3Y/X6ixafmao4eAk7lg1ovWtqoC9MK7Y4YDSd6EObDKIuMzFp+R2CJV
8K+PoT2LxoVapdXaWliiwPKLmKtRPB8M7aeF4dXwalmEqfuIySJjLdr3IsOScCrTYS7Ebefm
mqqPo6G6HFilBYPjIJOxbA4iSSxVnjGsXs5554NYU6WlEjAIi31AxfAjonSWOieJpKH6+GEw
JPGJr2lVPPw4GIzOMIe+Dw1qpWoQgRzWObwVazy9eP/e/61DLWJm93Gw9ApNBb0eXfk+aQ3V
xfUHB2DjKQKVgVdPR9UHqb5JO7nEEj9XWxYqjJi1DcbtTPmM3YLndCrtdNg9KGUsY+C9hRXH
2hckhgN7PfQBpJZ7ZY9SkWM2IdR/YisJQZbXH95fne7544gury37qqnL5WWfzENdfPg4TZla
9niMXQwGl/bR66y5ei399+oQ8N3huH99Ml8+Hr6t9pC7HrG+i3LBFsPpAxzSzQv+1X1K/T+3
9p1v9zA6HOdSyXxaRbDulFqVBEanLhzkihaZVks0Bd/ba3wJ3DZP5ylJXPxakcxNlRdnOC6r
LNRQxetcvweOzEM+IS0XlhGOaaG2QztKub/wrqpDwX9OoHxL1w5bjWe+ZQp+A13/+e/guHpZ
/zug4VvY8d+tdy/VSz9lzYVOs5KmPTTn4r2hnshSzAwbj+g7yihAsW5CEt1ZOv7bBhMHHBqq
oiQBvHGbUGfNujYwp7xetkCAgqo9NQGF/7ROX/eGHvOxIj4G0d2tQCr+ozXVP6LTmUSW9ifR
1ok6S+g0juXCfCt5WsmhH//6rLANXvYC8FtEnLwTdYAGmGMsAXuaTwZ8IRRkIMVyv903vaXu
Q/RyW9piTvDX5vgNuLu3KoqC3eoIgDjY1N+BOJtovqKcUu7N5+p5IJ8L5xrM0Cib/5exa+lu
G0fWf8XLmUXf5kOUqEUvKJKSGBEkTVAS7Q2P2/F054wT5zjOOT3//qIAkMSjQGWR2K6viEfh
VUAVCtiOk2M9nIIp0wnQ7uu2uDcEI86J1XWfTTr7/dQBWQWezZo9//zx8fb1jl+FwWoFaeyI
cVNGmDSL+re3b6//M9NVv264hK0TZs2n4z9Pr69/Pj3/9+73u9eXv56ese2MGgVCTgUqjYig
GVkOFwO0OTUDwyVTfnElPeMTGqZxSMjX8uAUz0gfiCv9VFmFeRgI8DzBM+HOVWqsDu4tpWYh
KE6PVQnLuYvaVw0lA5+KwPGgYFqbFZDGcrvOHHfkhGqcGgFMhGNonud3frhd3f1r/+X95cr+
/RtTVODu89W6/zw6fi4lomjphl4/NKzgdom+ff/54VzdikqLXcb/ZJpQRk3afg+7nFLbEglE
OAOedB8wjpAEPIYlMlmiXyFg0DTMtJEiP6vZBtrYBGkMn+oHBpu55RdBNFLLL0afUaTiMiWI
L5lCuqs1V66RwjYjKUptoijwXEgcO5EthnSnHZb3fed7EZYJABscCPw1BqRlQze+3yMQeFOc
4PbWOtaU5YmhPLHiIU00MeQNKL5I0uYRoAZAaIASPTGb2Lo0Wa/8NZIyQ+KVj4lZdEW8IiQO
g3ApQ+AIQ/RjtiXYhNF26WuSUqxATesHPgLQ6kKH5toyAoKKVdOkVvm1U09bJ6BumEbH5ims
BA0p0rhHW0halLC2q8tsX9DjHI/F+rarr8k1wQpP+ZgCpRCVJcvyRpdi+fIEsJqyWWaFdomQ
DS+skh0Jhq4+p0chabs83bVceSG2ME4svWOMpknDhhWW6y5VAwDO852yxsKfQ0MDhMR2UQ3F
6LuHDCMztbxgP5sGA9limDRsD48mOIFMQ9Zd0iaW9KHRj8hmiHv+8vAzmqIw4XnJ9hC5y14y
FyKHI/vCYTSZc+OtWKABqCamPUS7hDzR2mJ1NP3gBDVpmjLnOdpVY40bbTeobYbj6UPSJGaC
IAu5VTaSGxHHiZjBhNbhQtkIT6w8LSuMqPDU5kaGTj5jk24svWydphCk0LmQ88vpWhcRFEh3
SNI8TbDpQOUpmi4/ORI4JtU1waMjzUynXZcojqoK0uSHhKoSlZjoFsM1SWuyMscy7xg0bfNc
jcgwE4c4bki89rSlSMWTjG7iFa5J63ybeLP5NTZsedKZUrywSet7gW92To2Dn6qSHht7Gt+Z
rexFnxatK6XdOfA9H1uHLa5g60oELGNwO7hIqzj04xuJpQ9x2pHEX3l49QV+8PXtjs7RdbSx
tgILvCuLGWHNkq0XBXihMhh8qp+lCh4T0tBjobqiqHCed4UDOSRl4uyUAnX7+Gq8fQpxlPFs
9udPRUfPrnwOdZ0VmKeEVsciy/PGlcSRh7A6PqzWPX7GrTIXZcG60y/xsWnmRrkKON5zFYuu
6cNm7d/M6XCuHm93pfzU7QM/2NxqijJxzEJ5WbtKyue14Rp7nn8jecGpHfKqMFONfT9WTTAa
mtLI85wDixDq+9hCqjHl5R6uDxbNypkOPQTr8NZEQMb1HGtW0q/P5dBRRzWLKu8Lx3Akp43v
GMZMMSdwW9/RPhnbcXdR761xvE1os8vb9qEphv3VWfnigJ4Dqjz891aPBmfh18LRjzrwtQ3D
qHfLZ5r1sR6UdTHEI3L2IViHwYu1pmwAOmTc06FsnUsY6bmxB+2BfriJQ3fG05zowJuk+lQ4
xAZ4SNxY0S2AeXdud44uBTifJNxwRlJoDt8xB/Ps24UezxmyHLTl00IhZCzEGwlBiPzGDX8C
h/yFxhcTlQsMHKsZgI8PXVtXxVLaHdPX0lUkjI4OpoXRzdNI6MOCBPjvRRf4jm7W0VXsWitZ
E/IV1zlTM4bA0z3BFvgws6XNtXGWBcChcMmiJYN6GqAtfUWpBRfSMeoe/LTzg9AxfdKO7J0Z
nts92zyMlkl8Pe7jdXRrfekauo68jVMtesy7dYAeHWlco8kF0wlriN9ZDJd95FwK2/pIpN57
K6vinka9Y8Z6hEjX+hGYPH4oKLa7bEmxMryaOcnYDHAaE7QrBbYrNRLYe6FNmXq6Sg8yaU82
+X3fogQmJfSsYu5DrMUllNjsaAeRECwq/CT5+PT+WcRF+72+G42akteoFP8T/tcjvAoy6wji
zEdx2QB6m1zRES5QaVVnX6IeI8DCMKLHJRZftumAZpg0OyM5g6Eum5RxUdTBTFTxXK0K/QhL
AOKEV6WfDRkdEpJL8UzZjrSholGEX9ObWEpjPpQmFayVJnMLZiERZom/n96fnj9e3m0Xp041
WF1U67sMY9i1SUVFEASqco4MM+14tWmMbyZDFIlMs66fq6LfxkPTPahvEHAHFidRRIf6I4jW
ihNPBv4WYDaEy86WlYS+vH95erVNkfIIRAn1p3URBsVGYFXhxPb27TcO/BDpcscHxDgm00jI
jvXs0vNxbyitCFqQaSsh04XfZODOyksMo6HEXRDryFynD2d+gXS1jPPrKDguu8JSIS2HbZSB
qTxndzXYpi30VY1Eo/cWXbNHzDSlQ5uFAHRsNXc5QByl0PnNBEYIE4mDs2qlfH1T+seBpoXd
KJw8fxbguDVqJXykym0Os/gzeLsC+vKrEBfkSyhutZbwpYsjRzhkyQGWlIV+zmNgI/kK4Had
4OS/uEcSEMDtBO5tkdA0rfrGQV6QFdskrQu6QS/njGOmIGyjnSXo9/Ji+pI05QL9qUsO0Jfc
GUlGYLIqomA8mHct5go30y45ZxAW/g/fj5ji7ioV570pcNhhJ7JcVm8bsdvJSOfPhuJ11OGl
Dg4GmxuybFNbhkzfcQ1YwNhgF3L1rRzhGlTZLGfJeYpqX+Y9Wj0DX6gf+yvveRyR4lCwDQJ6
hDN24G5IaIr1bA78yqpBYG/gh9j2cEyrUX0gFOLSyIK7QYvZXvLd2WpGay66orGqBMhGpVUs
RnO2MinKXc50HaZzmlq5iQ7jELOKrXH9gnhh/bFrOV051fQrs0Rp15ajqU6HKuGGmQnvlNkJ
aDhmJbaZm8z2mtqqUuXlCKRFq3NZAgfuMX5JZ9XL3VQ8vKVqS1PovJYsfVPrFxH4FuaVAm4u
Wo/UcSo4H/I70dp2lyPcOZh7L+CWS2BixSr483Zdzo8SXJnTwkqfsnXQxc4fMszqg1lYCONe
77ULMPKSzglsscCzc9wcrJqUwAnqTUaZ4K5bZmPg7leqzzYn5oM2E0k8glTUxq2YGd8lqxA3
hcw8ovVvMIEu2VYHrMfPTHwqwoppXFFUAPWi5EzO+4eqphgCrYDRwVml0yMxT1jK+r0WhHlC
+qI5stV5PGCQnqPPyF50nmweqpQ7bKVokDg2TZCkGlaGwWWmr9AtVtoGK6HCjvFlXEUZP2E9
x2h1uDouYlVhZ1cp+9fgfUglcz54KlbThyXVZtNuJCjEIW2NYzaJgfsEYK4iSha+j7RT5h4a
jFLlandS0ep8qTt9nwyw62o5YBcmALgw0D8gVenC8LEJVm7EOFQ1UU1ATPEqH4wgUyNtqPfo
wmUfjEzHY7L52jNTQeZHEMbODI4lthOqWliQF3eVgmuaOnmKZzJPV0Dlb2eh3qIMJed+zJv8
fP348v315R9WbCgHjyaBHD/wpm534rCKpV6WeXXAF3mZA2e9wcD+dxdxKLt0FarWvhFo0mQb
rXwX8I8NtPnBFBGQSdmnTYm/7rIoGTV9GTcPDoz0jA3nIy7C8lDv5sCKkO50CgchyhySPxZ9
dMw03XHuOfztzrs/IcCZjLzyr69vPz5e/3f38vXPl8+fXz7f/S65fnv79huEZPm31s/kzsco
KV8bTaEl3RZfpDjY92i8GN57UxLEYWSmx8jCR8D92XCqq8T6rk0J7bDLULz3wyg13bkAkOET
nDXIcni9kEdtXLiqwTnHfYgutZzkl8Ag8RUy0olY4fjQGl+U/mQ9ZGB0iMOxZLOKI365YKGY
8sknZnLQiwM6Q9lYU05RN5q3MtCmWBJaZqecGONIAcsmDU7W8DOPF1WsW0dmvqTbrAPfSuWy
XvWOwwaO99jaz5cfoSTqmdSGXzCn6U78QLmWZjnYxHOrxzSEdVkjpaYyCtD0VldnJHgX8YIq
3AwXV3L1IKxAb4vCNaraU2jkS8M0WKnGcU48DoTNVuqukZMLopmnOa1prbkCjb0pAKZ87lc2
P5Bx9z2On6s12xgEV1e3Zgrf/Zmp5saY5Ce8CGnYNcRoj3PF1MxCj5Kq0oe9s3RTrC5H4a6k
0/MSZztmTn3pHtF92WzRYznepkxx/WOKFs60kG9sE82A39kqxJaGp89P37lqYl3r4JNZDQ6z
Z92KyWfSJlj7kbNEbb2ru/358XGoHVs8EHZSU7a5JEYTwHPUmpcBl2IBkRHkBRNel/rjb7EA
y4oo65xeCbmWq6q5c3nVeg2MLaM3lzwKMr9djCEQguGsPfMuFg94AEJXx2c6rPzWcsQRIxCE
VnqrwGqw2DSrKFBkBMcZyK46ed4SXVIFwdynC7YjAI6jZgFo9D+sDDktn2LIgOmbPP2A/jZf
mLRvFPF7rYbqMdPMg34A2m246g1ad9xsTTaSZMkQbjSbDefV9ioTaWDTRmZVMunF1Vum6Gpv
FgBtVmdsYnLWTRwCMc/EbXQ4UqsMoP/c29Si2yV6CHG+k3PGAVJQvK7KpSctyVkhcqQ6XWjS
PhOHw7gHxIjP5dA+5YEPTueqyVEvdTUky3BBsgbjBhwouzM3dS+gMY2I/UTjmArY6HWfzIcV
gFg2cbzyh7ZzBYsR5907PSkgWu0BRLuVuM4Ev6khiTRgbwKGJiVoUpPSaCcZukcXJlOShn2B
2kZHuLGKKY1WWlgRoNdi1jeIEKRuZbdjV/CO78iZB7DzPe9kfla3zmdS4HHIIg1Rp5ARG+i9
URmmfgWmBNl+5SQDXqnUJi32BsmSzf3Z+IppXuuVmQFN/bigay8wyEwho4UeFUjQHXViHxyR
MWa/2auCfIkjXbCxGwXUPNdnDb+4aeflNnqM6FJDQzQCmq4MOYArjZURqIfujEbd0MkBMd+c
IFcYA9/js9YyF+6iPSfisalLRjRFsmAonFk6sxg1UUcWPdsMEF1Yk56p0kqjF/ZdXtGE/dg3
B2M1fmSSQ9YgIJNmONhIQibljSsCyjmKHUgEBD+fRgF/8/728fb89io1CENfYP+0a85ccmW+
DnpjrTfUurlnw0E8RqcPTKch48OkOgfcLyF6SBXaEKzPHtWQJ+wP7dhO+MaxbbkeFGEmv36B
mDPaS80QX+SYYO3dqLce2R/TDX9xQt7QMT1b7MCdlvw14BM3TOgJSYg7QqGIXEKnjP7ib899
vL2reQm0a1gx3p7/awL5N/6uT3N8YCviHVx/r/LuWrcniFrMG4l2CYHozncfb6zaL3dsI8C2
MZ95LHe2t+Gp/vg/NXqPndksSJYSGNUwOyCrjLYqSwKPYwUBGtiaTZiyH/mTy0u9N0yQ4ydF
e68vDOK81LiEPxGHC3afhMPWU+OcOr1UoT6B9PXp+/eXz3f8vBUJ0c4/3LA1xgr/ozKYirgg
joeANnGgtgRMZVwUWbmWkfeNJYfxiM9VMMD7A52uEmmYOAa0ZevUhAVsXfHn5OxqPGrBqXmR
utY9gRMjmX0HPzz1NEVt0emcyMrp0DqPzDnuONETWHk126mozX4IN5/TiynEsmHaRm8Kwwq9
y6lkF6+p7vwt6Hn1aNy9Mhgafq/eVXxTJxXE3iwq6alBgQv7UxOZWG/2Z3lIohetzXAHQQ7S
hCRRFrDpo96dF9hcGpVEa1OQtILZVJglNLpdDTYJDb0IHmBk+kBT9AyVo+Oxl/6NUFFiLNa5
wI3LF5yIHYtx4FJACTpc7eIcPELRgIYtE7h1CibIJR6wXcwyEB7HETB1YUqcLCac+vLPd7bo
aPqFDJM/RiUxMhV0mOGdU2hWmSPucB3GMymtH0OEDIfH4cwQOIcLt3OFttgkfamQnGVjtnCT
7uNoY3bSju2JgtiayFgf2UqjuXJUZUhVLFD77BekHZgZJG3xKIw+2mSfbbwoiA2qeS2YE4U5
wprRwu0qtIjxJlpH5jzDxM8mJLNcghyZZFoGcYo1s4yz4Rxr/CpNvLa/AyDwHV79E0e8xg0f
M8fWX+hjkgPfnAmOe9IvTBUiFIjZOa7l2luZ1CuJt1stdiPSNaYtwGKXYZqMv15hQyr0t/6C
RMSgcypcJA3DOLYGRkFr2hrEvoX78WZXmh66ml3Z7LqIiE9sPlyso3YMPiWHfMaTu3x5//jJ
NGJDAdRG1OHA1pqkq82qkDoVrzZPuaCpzaK84vZf7q/Fg/9iVh+BwsOnpbaMqXTs8a6RLUsE
K964Uq9KsnTYJR1TY3G3PNb+8TaI7JQkDqf6ApxlJNNTI1RIBDZlBzD7sxnMW/v2J0naxdtV
pC3BI5ayWRjzJ5/wa+D5EfZlRoNNjA9qjQVvJY0FOwgbGcr8wDTbS4gVQT4asPA13elvdUpR
UTQwNUmqRKK2EHf3cAzVY8WQkCMOzFRTY3lQ6L46kY90uKC/EfOXlaPE8AlzZJKzImPOsHKN
ssBCnoxJtH2EN9/4sdV9LI6CNlDURR4+Hjzs+uTIMc/w1sewbqKxFlQGXY0aEXOTYxWL9wc0
0y5c3xAN+Az56wDb548sIhhkzQXgr9bRGstqXOoXC8rkt91gX3ObPCU7PBDQyMV68MqPMPVA
49h69qwDQBBtcGCjGqYUIGKZ4UC8RRsZoK1jtlF51ujGbhr2ZBeukKIK9QfPWWpA+IZyHCeH
5HzIocWD7Wp5vhuduhcmiraLvDC0S9l2bBJH5EnTYBMq0/7+nJeyRAD1iKTPKfU99Ux/kqGp
2c7AdruNNGXneCXonq875i1RI3NJgniNmuohzUYsJznLp4K7kNLfGl4VSthUR+dXzkZm3e4w
UuG9Df4aQ9cWDTa/j4zje9GHGiIz581wLWiOpagy7pOiFe+eou2LfcLfsqUN7qI9fqCnbQvG
LCQCgwV2MM2wKsNiQeC9Z2eT5eQ8vRRuJe04xONG0TnF2c+A9CMZ889gCj4hdklOIZbWuC1a
SJBHH8a+Fa+ouT+k5ypGKzAa2xa+hWMduw6cynp3iFSvaE/Xus6w/LIajATOvKRzgZUkKBrr
wKaDZXUmyjirHy+vcJz9/lW7SMzBJGWbhqLqwpXXIzyTmr7MN1/jxrIS7/++vz19fn77imQy
To0pCTa+jwlJujosyEkezdoCgfPcijoSHSjaR+ZnfF2FdsT+xwQ4jqeCPwS9lNvt9MSW9enr
j5/f/lrKTDiBLmbmSgXf6CAp8fzu2daNyQdr1SknJ8/YRJO7m9V43MprD6cjGxKU7aDPbFKt
bNy+4zNSBtOPYgKq+po81Gf8QtLEJW46cZ/6Ia9gHcLO6Sd2CP3KbUssYfUtqYmBPtC9/fb8
9enj+e/Pb3/dNe8vH1++vrz9/Lg7vDGRfXtTx8uUStPmMhNYCJBa6wwDzRFhmUxVXTeopAy+
JsE3Zxi/um7K9PUKW8Gg5/m83ndTmrjyJbSaZSaxP0N5VI5I7UPax+vw1sfrAP1YnEu5PyV5
tQ/8HUmR7gvmDm+9RRB5YxfL8LEoWjA0L8qDc9BmqWDjcSOayeT71vdLaSSUbIO1h1QAPPxb
BnoukCZki1dQ2EpWyxUc3dAWCrfvrlnn+VgBpJ8ygmRXhCi80xCA+w/Z5KbqV54XY8mLmwNo
vZmy1HbFjXatom7t3xgM/KXDZZbxbuOC+MYTCER6HQGH/h5c1BBY2H5QYBOgYoTHf3ABT6oi
cr+T9AFEudMom3PZ6EQ2S52xhOseroprrLQDcyVWcO7nbdP5/vxqvK3KfegO/W633AKCb3Hi
yIqky09YLxpvjaD9SBpib3QkpgTAQy2s9It4+5gYLNPQ5+Z7dAB3YE71lyo3qQZ25dou8/0t
1hm41mCTR+sh9kUaQd/RW0hYdZw1l6++LuFcZ8XFMroh6D1LpU7+NTO28cLY7MqHhqlnZt9q
oD6eI2t+iWVtVReCECSB7/joTEpVbqNd4bc/n368fJ4X8PTp/bOiojCOJkXEDZEba0qLnRYi
QPXOBxaqO8Tzr/jtV/5qEJqAwqDTxf1Xw42GiTRB0gGywSTeKVIdQjhZpkoK1TdKpGo8I86J
FCNWlnuemvSBJOmQEuwIRmOz66W5Z3GvuP/8/PYM3kzuJ9D3maUhA220LWCdaZ/JUGOHRgQA
1b+kIdvSOb4DMFDOp7hzhWWi5ZxJF8QbDy8cUxJYR8MjgwgG8LkHJ23xJq/xNYDHMkWPz4GD
B5T3dKMAp2fbaOOT6wWftiHtvgk8y2KgsRC4mOuSa0KLVDOJcAGBjhliB6ATqhogIB2p9Bqe
uQqyVEKhDztKKPRdLNU1dtAvQV+/Ac6pZYXZhwACh47TLtz+P2XX0tw4jqT/ik8bM7E70ST4
PtSBIimJbVJkkRSt6otC61JPOdZl19qune799ZsJkCIeCan3UOFSfgkgiUciASQSntYnpjVu
1aZ9r2e3gQkRnfv644YMrMirPnM95ekNiah6yMuAcmmRAy0LWaLRzHi4gswCMG4M+rYMfVC8
bV2aQBAcNGALxlRrdA2kgmzG7WIpt/JzH5I+HgjqLgxI44dGjkMRA4KoHS+J7n1w/SCiDm4m
WPN7WKhmHxH02PLC1YUhsfU8DseyS8ZEjRM55uqFyAKCqB7ALGQqvDVHh9ALzU8BakKfNnB4
XguSHMVv/OY5daDLFThiquTa+b6E7IZDYRsgaBHr/G22DmBs26oYeoExpC4nHUpGXRYMQUw/
wMrx+9ihHVI4KpY3VrwvMvuDAJyh9KPwYHsHQHDAgCjEwNHHPOWBw+l1QDp8cOz+SwxjQVPN
4uxmHuHLsnp1CBznxifA6soqvLi72skhUTidu/CpNCV+uKGbdC8mQdPPWqd8qpr2WeRdI63q
lDywafvQdeSjQnFSp8TOXqIAyyUuDk0GNXEIKnON0Tvwe1QROaFKuOKzJeUXE9Q4pORMXEqi
xDVmz5lue3FGZjGmKUBAY8sHhfPyXL3eyHknJN3nSkhp4VFF2loPlcsi79qwqWov8LT+Yrz/
xInc2UvrWE223aWbtFPJi3+eal4J8pV6mjkIyyfr/ahitMcC/9I6cB3a9WKGLc5uAsaZ4jps
mzEA9B1jxgCq5163JScW7XKTwRI4V2rs4jinKJoHP3Z1rc4jYueR6sotI9MRs6q3L6nYFeUu
mMC6PtR76pb3pP08BkNzvk6iq0YAOUS6AHEWvvegf2m9NmyYhyzHa8B2K3/IWGia+bJtdTmv
MBdW6NKFqp6chefdWXPsYlyw6li7DkYR+yT7OV5b6C17XRs88VWCes8kfdthAdbloQBboqmG
dFNQDBgvbC+iJ/Z7rVkWLjyn5sfUFz7LxtKcAIzLjeZ7SvGopqoGhbKFt2C4sI3DgBY0zQMv
obupxLSDP7RzlMQklq+3uLoa7AHympfEpK2ZF4Rap0qoGJA3RJgG9A0umzuh1IfmVSiRWqwZ
bxSBq0RGmVIKC1NfhdKw68nX6S7wAtnVRsPi2JK5xaFsYRDrOSpjgYyBZ8laLPiuZl72FSyF
SbEBClnkphRGTK0SCEZe5NIicexWc3H3vFvdhttRdHAPjSmk9htUHvkhVwkRpoYNCqOQgnCV
Gqh+8QrI16hXJTI99RUsDv3EmnschjczV1eoGsTIzsAh2xjkYESt4jSexFYsX4nbscSzYrFD
qi+BMTrPafNFewpDwcUzQtS3AgiVdP1bs9aF5qMFawPx0i2VdxvH5MuzKou8IJCRz1HCLJoA
dwhc2stQZbrRedpVmfZU6Xgxxw8spbfr+GC5LyQz7X8rXOdG+SPo0dBWDIIWh0+NK7lRzENN
fSQ/eOvaekuXP/nN5shyQwjBSl/C1rjwTaJRCcW3MMi3U9U3HNVQFVKKwRcPuBFCia2VG5J3
Qz3eUF89q9vUIWcshHqXhoI6jkJSQVy8VQl55o2Q6xJVG1h/0QadsO5XTaOHG9JZxq5Yr/Z0
DC2dt32g7mjIXNp6QYb4+ug41nVG4vC9TkjOygDFzCe1A4eiHQXBIj9wQ4/UVuZuiooxLyQr
VeyaMFJtm7svOkZPBeZOjIa59m+Y9mpsWEy3u0AtizWNzXadTWOz3Wkz2G7ZSPPWzNVuZlxy
k9ZNy61Yc+WFsQYowNxMUDBY69/WZ1W6KlfyC1KZPhFjhC9py7kqO/V9Kgw9ljW5thpXcQx3
TQZOLvTikLJrhnKtVAZS21JxYeaeERzo6F2TKc0RFDKaz7tfbe4VnBPvjSmPRnHRtpEnr8eQ
Jlw20oaiblyWGpB6esvLmp6c6QPFCY9DlvvPArNFv0HUeJxmwvhDivuqL2JkWwRBepeWu36b
5s2DiolqWapEq/QJOK7LarAs8GfGVd6NPJptX1RFphziTlEnvj6d5p2Mjz9/yC9ATY2T1hjA
zWgfgcIKvWo2x2G0MaCXzIDPjFg5ujTnL2qRYJ93NmgOvWDD+RVAuQ4vt8qNT5aq4vH17WzG
WBnLvGiOSrCaqXYaHmFGCdCfj6tlf1cpVMl8uu759fzqV08vP/+4e/2B20rveqmjX0lDYKGp
JycSHVu9gFZX92UFQ5qP5t1MhUNsRNXljhtUu40cQpVnv2Whr5Hqombw76iFRuEYd8A4VpBn
Bv+jlJBge9iBDtO+B+wLdJQmqHkt6r7cyLVM1abStpf4hUtd6wrt0qDYjnaVtbB1xec9djVR
3yJQzvP59H7GlLyPfTt98IA3Zx4m56spTXf+75/n94+7VOwuF4e26Mq62MHAkX29rV/BmfKn
fz59nJ7vhtHsSdgla2Ua4ZT0AB0ibUGJ9J/cUIamIEmiH/RqsrzAcNs9qJMSdG7V9D0GI1F5
9lVx2eu8yE9IKCsh0y9Z1DVqymkck9u4OY89MH3Gnyp9KNIgUgw2oW1KP5IvAPMiNJoIj6vS
ltTyg6dzalf1J7noJw4Ros8l6HnVnbLbyp+87VedIcY27e5JIlMT38MiqPikzTxdUTc7JXYi
LzpNyENWqTbV+/oKcDwM9J0eIVqaRpETbs02Woex6ugiAHEgRs5voDMmprKf/bRI3TIpDKaZ
OQudUK+cDvqskR3PFkTRPWZ+dVpVja6ZLwl7PZFQf0Mr0+HjLr1n+jZTldd1O03OVl0++Web
aWfH7awvWUdtiZpsw8HMZnakHtsSVHLZg9BfrJkpzBkM131HSJbXoe+Hx4x2GZt5vCDgLFR6
LwygU5ARjHVBVsUstd4oPJLlccR7FWO3XtlhYorlPrnW0mEyhHRmspGMzDk19f5ASeCZuXDy
jRkeo2BGf5hpRfBxsI2tAwld9pFDDo05AXydn2d1qSOzD3NW7A1ovg2IN9yNHCcjXXii+cdS
H4sSgg9n1I1uJ6B9D+ZMbVhJSOfBkaFfEwNr8n3DlPx1K2ttzAJwzmvytUJnXPq82l9q34sO
0BvXBmQGVJLp0+i90lwTn6pcZGQcjMrhNy0xZ7NYDsHYsZYn/D2VQIMqYPQO4d2akUA4A5oY
A8Y/pp87Rc15MUatkwIaKIR+nVBccthRqSYAk8eBX4klh1Vhj2Vt12ljCX+NqQGJ6tJQBtB+
A5O7/xT6OgxVYKbBXQIpK6wGm8SIQbJB879Vl1DyvUlBOr08Pj0/n97+NN2fhRBlNy1bxP3Y
n1+fXmEp9viKAXD+4+7H2+vj+f0dQ09iEMnvT38QWQzj7FOj94s8jXwyJPAFT2I5mtFELtLQ
dwOjjjldPUGYtHHfej65Mz/Nmr3nObGeXdYHnh9Q1MpjqVF4NXrMScuMecbks89T1/ONNeFD
HUdRYIqLdI86Rpm6Rcuivm6NCaZvdl+Oq2F9FNhyV/kvtRlv3i7vL4x6K4IxGM6h2aacFfZl
dWzNAtaykRsb7SnIxNyIgB/T+5ILR+hQu3YLHvuEZpwAHKrWxKshdhNdWCAGIUEMQ7OQ+96x
hWWcOmYVh/AB4TUeNMJtzlUyx7Vq4ufAMNSusYxt4Fq2iiWO4JogwBE5zpXx/MBixyf0wEOi
hcKhGKhQaAvsGt1qbA8eYwYZdHDC+A691GNxIJyUcUJ0/8iNjEGXHVgQ+0o4Pm0MSKWcX67k
zSJjQCM5NjQQHy4RPYoiktvzLYPLI73DFzxwDStvIlNzXJonXpysiKLu45h8qXxqvm0fM4eo
w0t9SXX49B301/+cMSDAHT6mpWw/TOq2zUPf8Vz7MktwTCpHKdLMfpn3fhEsj6/AAwoUPcos
EqCujAK2pZ8WuZ6ZCGqQd3cfP1/Ob5cSJFsHejBzp4ljDl+g8YsZ/un98QyT+8v59ef73bfz
8w8pP32EbfvII8NRTaMmYFFi9DliQxOsE7TUc4cpu6l2UYQsp+/ntxMU+wLzkvScpNqN2qHc
4TZypRe6LQNTKeNNV5fQNpyeXNE2yBDQvmELQ2SfdBBOCDME6N6tgj3var5eQNgLzeiw1LWb
N83IQtOKQmpgTG9IjQnZOZ3yQ7rAEVVEQBYMVPIzgH5tJuQMlJ/wDIfaNZklmcXbUGK49m1B
mBh6tRkjFhjaEagRM5f+MMdT9RCFphrHHCjeOA4ICwPppHvYDCehT1ZJQkdXu8AwZ5gyuF4c
GGby2IchM5jrIakdx6gfTvYMSxjJrjnXALlVvPcv5MFRnUAWwHXt9gfgo+PSCUfnykIEcUK+
vnM8p808o7l2TbNzXBKqg7qpiLVml6dZza51U8FB7fVO+K+BvyM+rg/uw5QOsi0xXDO/gMEv
ss014xBYglVKO5dMlhL5ELDAiiEu7mNK9Czyao+cRekpg88mFdCo04nZTAniqxWd3kfeFX2Q
PySRa3R4pIbEJwA9dqLjmNXkVyiiclnXz6f3b9SLyrP06Jtnn6jxxklo9Dqghn4oz8hqMZfg
v9ethE3vhrqzshRt15zXxSYDYql4Ak/JNDvkLI4d8chHd23nQslh/rTp1Hi/Wx7zzX6+f7x+
f/rfMx5ZcYOIOJ7iKaYbbdbzQsE0wMo9ZtrlSxWPGemMZ3Ap17WMIiLXiiZxHFlAfohjS8lB
S8q6LzUNqqADc8igkjqT3NEMzLuSPQup1ZzG5HpWCT8PrkNaPDLTIWOOHNdRxQLt6XEVxYfJ
b0l4qCCPoLdUAUcjwhlkwjPf72PS4lbY0NZXbtsZXce1fOI6cxzX0jk4xq5g1sabyiSvp0ts
ha+4K6r5g3Vtrfo6jrs+hMR0GBFFlH2aOPQNU2WcMzeIbMWVQ+J6lttMElsHMwYZUEFtcc9x
u7W1z9Zu7kLd+rfqjjOuoAqUkO2UapN13vv5Dv0f1m+vLx+Q5BLSkF+Bev84vXw9vX29+9v7
6QMWYk8f57/f/S6xTmLgLnI/rJw4kVYGEzF01QEjyKOTOH9Ytuw5Km/MTMTQdZ0/KKqrEnEM
yffpOC2O895zefx36vse+cNG/34HMwWsqz/enk7P1i/Nu8O9/kWzOs5YTscO4NKWOCgtX13v
4tiPmCY2J16EBtI/emtjKGVlB+a7pK67oMzTv6IePHKIIvZbBQ3phap8gpgY7RtsXd9iLM0t
DFO4tf1XoUN3GpZQG9xS/zC6h5M4GhGnVSc2vh1b0HHIlxPmVCzUetpY9O4hMbOadETu0tPB
wiNaiZIFCqOmUpE0nQaV0d6hnpMg08vjpSPYhMQOq4+koYfpUSschpajC4SvDqVuaNQ9SM6t
lkuHHu7+9ldGXd+CQaO3L9IOxDezyFrxAmVkl7W4fU6DnjrrR6gK/Sh26f7k2xpxdxioTg4j
MLALgcPNC+g1FxeyXGFD1HQIc5mDduWdOCLksMg9wZqHGVATowdMNRCr1HSdOLIjFNKKzDJJ
eJYzDtGQsAxgDnXj4AL7ru6w2Q0Viz2HIjKSiHunWq9DNR7r4v6WuzCPo9NcY+so08JF7vzZ
NPVYuz2qmFgfb6JmmUtSPVMHMn4DTWxJDz2UuXt9+/h2l8JS+Onx9PLL/evb+fRyNyzD8JeM
T4j5MFolgx7MHEfTDk0XuEyfkJEobikoNbbKYNFpnaKqTT54np7/RA30vCZ6SG3eCxzaTNce
OOQdzWJJ93HAGEU7QmWQ9NGvSG1C3p2dDJQwYXOLlH3+15VgwgxFA2Mvts8zXA0zp1dKU22I
f/t/iTBkeCvZaExuqfiqTay4q0p5372+PP85GaO/tFWlFqBs1C9TJXwmzByGlpBAdUEt9iaK
bPajnTct7n5/fROGlGHVecnhy69af9uttvLV0AstMWitPh45TetKeLvYN7svJ5ObdAuqjWvc
QfD0wdHHm0qXFon6JJ4OK7CIPbM28zQMA5thXh5Y4ASj0fS49mL2Loga39NE3TbdvvdSTao+
awZWaJxFJbxahYX7+v376wsPkf72++nxfPe3Yhc4jLl/l/2lDaeUWfs6xgKlVQ6cbIsiEan8
9fX5HR82hZ50fn79cfdy/pd1jbCv6y/HNXE3wHSd4Zlv3k4/vj09Eu++4mMAZbsfPSOYTN7V
Ro9PgSbvAs6HhxJZ7Be+nb6f7/7z5++/Q33l+snZGqqrzqtSdicGGr8w9EUmyeKsy67GV+eP
sCilpkDMFP6ty6rqimxQckYga9ovkDw1gLJON8WqKs0kXTEe2/JQVP2x3B1XXwZV3v5LTxeH
AFkcAnJxy8eB4FD95WZ3LHaw6Kac4+YSFX/iNTrSr4uuK/KjfEEJ6Ks0u6/KzVaVDeyHAnt9
q7lqATSUFRdswBd29ZZXWvQbrGr/dXo7U/vZWHfTY6r0R0CPUyRK1ZtovKn4tQjSNgO4WNO3
qwDarKjNUwDasWNKqRj3HXu8Wpe9m2sRB1FAdDtUKA91HMjxHThpOG6KY6e3TntIhTknsWrm
KJa7hYZZQf0fLVEusXlqrYGRcEyzrKhU6XpPr1B0uOXevHhvEJ9nsdRSX/fZfq1+/T6vtNzK
VX3cHAY/sFw/x3awv66DPTaNtSqewtJoBdUFdINdU1ukXXVNmvfbotCHknUXHbEeLelI7Qvo
h21SpiozLoZd8N2+hh/9J89M2aPKKKlEed/TVD2qj4mt9RG74BneIsoGfOaTP+9D3+JUs2yp
i/IKywhjxCLQNq9Lw2F64vAvHAYUyBAtV5/flCvvzZwFUoOiXmf3R1Bvxza7l190UAupiqIF
22EAPvxK851CrtMwwXp1155ezs/cH6sQ3j/S8wd67qhWcsi1aVMvpHrVzDCsW9/VFYHG0uYu
6x2X2tW7MMPvnXi9LB/pWl04sOL/Wl6XK5nEF7Tprqiw/9gxfKO+tsLcKzTNDkEYpPd2tmrT
bsuqbPtjtXK84LO6r6LnuU279lj1jheNUf7g0IE5tERDiw69DouHocgoA5nm9716KFLXKvgO
rz9XsePH22o62p8spZsdas4R7+XgrRL5i2eadG+QPiQAvou823FDn7Mj11rby5nPYSnzTTwR
dHr8r+enf377gHUdTFXzBVjDrARM3NScro0vVYVI5a8dh/lskF9M5UDds9jbrOXJldOH0Quc
z6NKhb6RMNmzZSZ68pYGEoe8YX6t0sbNhvkeS32VTL3FjvS07r0wWW9Il89J9sBx79f6N20P
saee9SC1wasujIzXfTHc9Bq8ZLBwiCsRutFAMN4POSNP6BeWS1xIInn7QEdfWThEPLGrBRih
kBZIPL9QFTkFGvHGFSiO1dg1GhhRC8eFx3zGVUovYsJREPoueE5Kl8tB6ihBYmnjICALNSO3
Sq2Q7vKGvKm38JhBbBfMjNqxYFp4+kWeEao+qloKW+Wh60SWyu+yQ7Yjg+JfeKbgiZZaLHJS
Od1QQXMp3DlEW+1M0GR+TEv+l/fXZ1jJPL3/eD7Ny2bi7v6GX9fsG/kVArEOv05G02xf7/pP
sUPjXfPQf2LBZSrp0hqMvfUaD3D0nAlwerz02Hawsuy+XOftmmF+RfBqjtOKckjvi2acIvjM
mxjXK+yi+ZqN1J3w1xEW/PvDUb8vLEFQxy6pXReWrNoPjCln0Mbexpysb/Y7SZ/wn8eGG8vq
ToeK4GtYoHhL6oyiVzLc5cc5tqlEamXDBwld+lCXeakSoTR801El1uUBLUd5hTDlaCXCfLXf
lDsCJESz3cfnZadQu2mXw3KGyfQ5TAis6KbgBHI5XZMd11pOIwYy7wsOqksWFS13wz1dx9Kl
f504p7ckxA8/dPudvphCLBuq45hWZW48pMm/EwMw7DKLScXLN68CchWyzf/BveflHbELTRZg
i4+WdwW/2Q2L1N8K6codF0Gv3nSIvIzJ51kyFYZntylAC5dDlw7FJ3yqyVFFxvfhbZ8jnmGx
wn1DmxS8DWG5rgbYFBVR5qbi3MoXEuHH8iT40BW7zaDEfQMcRgtZ7n5LbvthjtMriLNK73+c
H/EcABMYe7XIn/qgMbeqVGmW7Xm0N53c7Q+ahIJ4XNOOpZyhpfcfLljZacX0ciw6TtljR9Fq
rqjuy51OGxqw49catdysip1BzrYY106nlfBLJ4J6SHUhs2YvgpMq31qnGXRo6sI+oqAD8vK+
+D/Knm25cVzHX8njnKqdHUuyZHm39kGmZJsT3SLKjtMvqp5uT05q0klXOlNne79+CZKSeAHt
nIfpjAGIBMEbCILAA7M/I8K5yPMV4W3vKegGm0WsO54L5AOfQ8wpkA+cXVN3FF0agKComCOQ
osxqG1IQPaORhDUW4BNvkgnaFdWGmskbBHjbYfuIQJVNRxu73/dN2RdaPA7522H8SPlKllOn
uj5JI3wFAzTnWoxxD0e3D4VZy4HwrddIbEIha1fZm3knJUPFPT/WU8x4KTh76JxlF+AUokN4
vqF9YZP/nm1Q/Rdw/T2t95lTw21RM8oXGjRHNhCURKS6tr9z9E8DVzfHxo/mUoMlxlNhlXGh
VrzrneZVXLadl9Eqe7CyUwGUK2pi6DtlUdI1kJPTyyZXxfhKXDz4CQ5lTy+NmLqnJjN13+kB
TQDElQdjQMOqkNWQEZZPAGPCaGBrddW/LWouurq3Siz6rHyoTxYUUuuRHAUOejwOHY7cm+ho
b3l8vDAcQ+yVtOXLDvSzzMBuiBzCiDCppHuXVK7on+wxwIvLneHEFTCS+fufL/G8ay6gRewM
DxvM2DSERW+7tRkQQUy45n6hkr7IcNOCwhYl45s7GndQUBxqrgFbgu8qa1juIIJrxqh2HTeB
nLWV8XNU/3vzYJarQ51P+GZlbRF8iWRF4ewH/Z4vRb4dod93B9ZXmR00VYf7J8YBVKehZZHJ
yCHcfiq6xmbkPuPbnKeke0qrxl17T5TPPM8nUIUprxHiyOrTQ84VKHe9YnydBhP1AYuXJlSi
srX6uSJtGIaGgRVT/sZMiLiCCgGrpJJqTkSKL/+KPC/wpyF2NdItJiRW3VNxEL1LrJK4Njmj
h13DVakTWqlT/nQM0TnRGtDsCYWoND0/7csL51mwWqA0Ezjd9hiygJh8sOgjnQboQ9nSwYi0
LIuqa8viBOCsI/thn7Fhry+yBz3ppCCra74DkGKoi/sxLOmo/JuPeqE3nDB2IhKaSnMNhiHK
ertRW14w3N+JhdVafAxC80TtkUHT7+wKOEjoxgd+KOX1+z8Egz8kMR+KE5/9dVbCBDHFAVRb
VplA2I1Ev+yKTuT4dLpTxPM88BVaHK0helVo8liZW9A8i15/vIMZaPSHce7CRA8nq9Ni4XTk
cIKRh0Pzzc5IizYhWv6fCgCFYWeDvVMPF+0GgVf9rd0hEn4sNlj8rIkAIvbYX246UvFqvEOk
UC32EjSnQxgs9q1NpJFAaKsgObmCA0SUhC5iy0cFL9VFcN0hglSGEmEyco3TQxCFF7hkZRoE
bo0TmHPbYChTCxKBBVPwFFuvLnIDJUIaVQ83gGb20gFAEa2okurSNKhVWnvy/PnHD9dqIOYL
qWw2hQ3LYzEC/H2OqzaA600vacFIzXfd/7oRgukbrtQXN1/P38H96+b15YYRRm/++Pv9ZlPe
wqo3sPzm2+ef45Oaz88/Xm/+ON+8nM9fz1//mxd6Nkran5+/C+/EbxA+9unlz1d9G9IpsTlP
v31+fHp5xJ6AikGVkxT10BNIOIjIM4DxEclrdiEkp/i0P9hRLTlkULmDTRYA4QtZJwhE/+ed
FT1ZgmWBKuzq53cup283u+e/zzfl55/nN3MgiC96/k9iJMCbUDlrnQEtEIdT7BeS+EflCZ82
MzEy+Qj/9vr1bLwZFaOPNkNTo6YXsTTUx4KfMjKIGmdymd+TyIWIrRoB+2UjF/4bhmlU4tNG
Bos1d0xAyKB2HsYFBdiM+JG9QBiao3QjSK4oSfcftF7vTiuwd4blZwLT6pRWWDuw285xUV4l
C3el5kB8CRcIyF/dyeuead6BYDEvOzFf+bnIjGA3fWZqQehyVlRUd09RoDCx25nlh/6AufJJ
Fo6scJSbstg1PZhUPF+VtgiUSY//XRHzia7EglUAO6wI8eWjJUXf/fqcWsY90RawvTqxOgV0
qLZ02PIjFtmDVd3mgSuJ/I/PlUI0yrcr8inIddUj3XRmOjfBfHOfdR21wbBD2RwUe1b0cu/a
0hOEgPSOPjBebO/tAh74J/ijUlH8JyG3E/48SKyRhw38DePg5Fd29owrw/x/otgTO0snWuJR
0oQ0aX078F4Sb8aZfRDZZw2TFtj53phrYXJP5qdUM/XZNCvaf/788fSFHw7Foo5Pi3avjYxx
EXIxddNKrZAUVPNKUVlaifTPMU8uCseLcU80cBSyEtL02f7YKMrZEjAC5WqxeRgPMl5ZCwUR
fY8sB9qObxBGyw7q0OZChI3XPEf8/mm5Wi1UAcYZ2CNrk7ldlu8KbEnuH9rCcGIVgKEnLbYM
SOTBiP8JvwZCNFukKkJkAklPNnyfR4yZodkkgsFOHxgeIhIhXFZUVuBpiPU/v59/JfL97/fn
8/+e337Lz9qvG/avp/cv/3StELJMCIne0ggm0CKOQluo/27pNlvZ8/v57eXz+/mm4gqFOwEk
E3k7ZGVfWfZEiauPVCRskHivBeRyffrAgg1vYPe0J8ZFYOV5Q1gV/KxFCXZvDMYA0wYrzsDC
hwqDDaMtfXZFmHHC8k2assGVe0G56WChrWHj2t/DolTvzCsDGfelQG4hxfeu65EAZ3W0CON1
5nCWdbTA4qJLJIuSZZzZZd2HVtgEyTmpkijEXkjPaD2okhSMmbRcwrrFAp6iLZ0qijKIw0WE
v9sRFMLdbOF8KMCYZjVj3QaJUDKXPkrWoS1ngC6Ck1MWi0i49CTYlI1uNnz8D3cH9LGBTtJl
d1alkNItNh8r6nBf4kpBo+xlVssh+Te2i05Y3RVMAePFyZFGG8cifZ/p0T3h9OdnMzBCgIlb
Xxov3M/NBJEj0HLmm4WD5tyc0ElkN2jKb2oCSRAu2SKN3Urusa1FoJBcvHKe5KGRKVG2oY/i
tTtClQ+jf1SpBIk+HmpmV1QX/WmjX7apdYASu1d6kkFyMIenviTxOkCD6kiW5pSZFq8y76S/
MTBN0Yd+Atv0of6aW8DAP1U+WzVLoiwKtmUUrL1cKorQGdKQ4Y4P6U3ZT1v0vBgLU8gfz08v
f/0S/EPsWd1uc6PufP9+AZds5Crh5pf5Eucf+nlMjgfQWnGLj2TogRHTpmoNwSpdxN5VuSpP
XWF3N2RqtpsNBvcH8/pGdjfl/XJQU9xXi5ucTgq5jeweY7sqCpbIAr5z3w3KwF7g796/vnEF
xdwUze87eFmEvXhQ2DQOYr0/+7enx0d3d1W2b3vrH03ilnecgeMaP9s3vQfLz4+3HlTV567U
FW5fZF2/KTJM3TUI9ftnvCjSHvyDaCTKSE+PtMesQwadeQtjtlRdkogNQcj76fs7vNz/cfMu
hT5Plvr8/ucTqHvwUvbPp8ebX6Bv3j+/PZ7f3Zky9QI/GzNa1FeFIlOUeCXSZrjniUUEjmf2
5jbJyw4HbzLa414S8PyOMbqhJS7qgu84WAq2rifeTFZ5lc2XWg7M9mzUMMcRJZ/GV5n79DZj
DzU/BJ2Goha3SqC1itczowY+l8pJdsYTXYBN+ePldyaHQ6Nd9WaQVS4bKraT9sdZZCcKxFh3
ccVzYBtI5qY7DULJcNA043OJNDhZEJw8gYAADdkfMAHfT0zMtRTtOuK7hWEs3bKS96DJPq12
YO4GQqRouA8owSaVmQmOFLzhRyvrw4nkNvKUWZHtyMUIoSVfSQ49eLLrbZjgJwsOD4LMEjik
t1pWHYdTg9nsqhMbLNp6026VDHEvUZnJ5Rq2Qi2LEl0ZDLO2y83OUXr62I3zQRVsGuFiyNqN
lwFJEyz8vcH3B+dzhRqzfAoO9duEEW5J/wT+qbYAVeqUTw/1Hbzqaj1d398Oe2b2HAeROwMk
LBG8JRZkD8NwqHZVjyG0+XUvZGjltlJQnWe2HTx8jul5rEayPUAKvqWhXpky/4khq7EgYWE3
MFx7saeiWHIsY99MLZLldA3jC0rnTsXSasi0ZJLnp/PLu6GWTIsm3ngONW2U8+I5rmRj6ZDq
2PFHEKVvqXllwe4FHBt+shxLEJDOsGqOhYqi4FsTRdZD+5LMJmBFuYUWeTYnIOHajHnJpcNB
0e0LXBE26Ig9+cYUf6aktJ44nJAEYbNNET08H7e6hgO/uJAo14LN/FkAH30JPKXwGa8n75xA
yBM92CgvZpQDD3qtKPF7qIr64AA38GDAzEsl4LRuD71bRGVntZnAY9QNLJXvTC8sy8CIMz2q
py9vrz9e/3y/2f/8fn779XjzKBJO6m5NU2z9y6Qj07uueDDM3gowFPp5ly9ahensLCHe+94J
LRVYMajpp2K43fxPuFimF8j40VanXDhVVpQRrGNtussZBRWRfIPh5odSaAKxEliQSA8Ji+mM
LVIMUQPublgtFhewXNcNlx58mW1aYjllzFgxji62/O6QgfMz1NMOaIBtRSgWeU/T836dBs4Q
AAbg4t2wJ82l5eZbDQMBd3uXuJZUjO7QNV4RHavb1LCdKXgaxksMGKNArrc68Fv5t6QbvKe9
HYU02Ld2sz7jm9J0QKB8tfzxrvw6psO4jPPz5cv5+fz2+u38bpysM776Bkm4MOxbCrhcoGu5
VZQs/uXz8+ujCHak4nfxQyOv365sleohHvnvMDUyslwsR69pRP/x9OvXp7fzl3eR2gSts19F
ZqUCYL7NGoEy1YjNzrXKVHKR75+/cLIXSO17VQ4rM0769Y9VcDSofYqRxn6+vP/z/OPJKHpt
RCYUv43Xld4ypMPS+f1fr29/iZb//L/z23/c0G/fz18FYwRtSryOjAw3HyxBjcp3Pkr5l+e3
x583YkDB2KVEr6BYpfpcVAAzK8wIZCq59TRUfeWL6rvzj9dnMB1e7a+QBWFgjNRr306evMic
tKav9BLS932RbUa8KDA3/hkufVhQPUQjGjNp2mVDjLCxUmkG+s/qFP+W/Lb6LR1j4f/9hz89
AHwPzmu+6jl+NSVpVIK4XIX5vXQIOuYFkslVxKPx1jzlDsU/Zof6hLEtr82Pswdh9vL17fXp
q3lo2Fe2DjytE5JaPxDLrt00WYf5kezYsG132aZpTL+QmnJVm7UZdmqHCFFbOzQShwzZrgrC
ZHk7bLHbREW0yZMkWq60maQQEM5iudjUOGKVo/A48sBXOcIghPAIEuwqRCMwYnwY8NhTZLTE
7iINggAtcpn64AlSVUtyvrZgY04RdFmarjAmWZJD0iT/l5wgCEKXGVa0LA5jF74PggXGI0TB
ClM87ZNGEqF2eIMgcSsFeIQwCfA4wLjpV6so9o9hQZCuj8inPa0fSo+P8EhSQia3C/1xIEES
YHxxxAp1nRnxbc6/XC3cSXIvTM1Nrx3PKjhWcQWtbeqi7g3lWqDEioP7PAA6pxXumiWw8AAE
WTXUWQqWjU53bRwRY0xFF2M9iBnB4l4CZWOiaLDz2IxtWrjfcCscn2Ba4C67d4GuL93U0o7m
uyI3PZpGpHnTMUJHHc7mxxPwZsQzNHraiD1kupfUBNXdvkYgvHnROgBM4GIomNY4Dg75cjkc
+W51Z9iJ6nxE4sd5mQvUpcAKHqpKf3Pe0qXpa3GiJVjOYeBsMUvLlhZlDo0yzCT7CpxaoLFM
vQSaN8mOnBTuWlArKKXtmi2tUY8xcKvb0yhZLSwxq0iERh8rGG9gW6CVkT2fL8VkDsKPu1VR
llndnFCr0UTVlPwwfWoCNHnTHgLgkFKbD/wHGJT4RLk9aIrYSAjxI1pjxsrrXFWIVECeX7/8
pV9zQ3jW7vzn+e0MWvVXrr4/vhhqGiWoYzTUx9rU1GQ/WLpexp7ltxjDysEgTXxIvsPGKG5P
Exk+ST/6jkhG0CB3BoV+mtMRNDaUAAsVe1GmB5SJQ3UBk8SMPK3hNlWQppjaotGQnBSrBS5E
wK1NjUjHisDKA8Es6BoZXINty+I0HpdwCpZdkfquqGjtKyETT4V9BppJVGHVMjTyOWD7+zJZ
LH2ihOsq/ndXYL4PQHDXdPTOmIlDyYJFmIr0njndeQoW9zuXm142ZF9nVvQMDe/bbTSS5lRn
HlvaSHIkvo6uqjaUN9yXS9jkqyC17FtTH9MT31krIwqtkCuBx+rMBDb3fEDEupfPBF2h0LUN
lQEoN7Rnw33H5c+BdZjuW2KSbTJ6m5VDH1jgPhgIOahw77NINFROj56BAHviKgiG/Ng6H1/Y
ahV+SCLUpUpHD7tMDyY9om6bOkNlTyGWkktPHna1uaGOmH2Ha4sjvmbonJ+woVsZ60xYx6fs
BuLJeFcFvh/HQUKOEeoEahOu/aUkyfUCEu8aypGrdUqOoSdesbmvhGi+GhEeFt6T+tq6aRge
YaQ6EWeHl+aYCoHVCMwZhAJ651zP0JfH88vTlxv2SpA3P7TmyxTlvOxGFzC9WB0Lvha2MddD
FsbYY32byuwZG5ter+pkpzryUKXRZaqeT3suQNQog0oPGWrawzTNWUD59tml4/qYsGf157+g
rrmD9OV6fgeIIPtwtcAVEYniazR7YJcIaLW7QgH2MPZgXwFZRHu65TTX5pQiLvq9Rewl3eTt
Ffb4VnaFYhfll/lHU5EZNMkqwbVPiZL7qZ8NQUOyC30hKHakuMSooBEdel3Oglb27UfaxvWF
5ko3y9q3Hy4RsqwvsuslAtnm3yk0yK6IURBtPlRzmH1cmoL+Y5yufBuYRH68EzntRzsRSNvi
kmg4xZUxyCmuzXZJVNTko0zxIUO2u0tVXpzByWq9uoCaFjgft5zEleAFYtX+j1K7gsCpV1yZ
+BAVbog1qNIANd9YNIlPbIC6LHNBMW0MPiY4jezbj3CcrNxB76W8NgbTYIW/KLWo0o9QxWac
Wb9xw9iqtd1c+bFIA8i359dHrjl8V4/jjdQ4HyHXTEqszyARMomCaKj44QURnXDh2+WMoB2p
3rBPJUrfwDiyyrLwqwtVicNYSxhnq0rXZhJIk4Dlpxg/Gk10rMqHDn3EmbV3fC8kQ7pIDVsK
wKtKITBlk+OzVgTC1UyXEzRZ6KmIqapkuQjWLlTRzmrjxFKCPwcDghIhcL7X79G4GCU0MTJV
j1BLwjMcjSg+o+3CSheaS9p1Ehh2AoCXCu6pQnaAU4esebW0GVbkK6y/5u/WmFDW68SEqrJs
sCJOHVm1B4W53JS1Niru+NiVo0LjiBHYODl0FaQLAwweiBh8NwNn87wCh55TjsLzZWuBekKT
oWwzFZgarVM01wFX/BMHKK8VHGre+7Kh6dIYFkwNF+vwbeCFMC8RSP7w8zuIvT90cO+9XCzN
ZYUNdwljENp2iV7djcxhPMsRsMTGMuBHMchPNYTqVwcuesBFnAQDsVn/XEoYY20eR24Q612g
gKH51G4ER7FHvlNbA29dEh9atU0isNmYEOYXbUXFS3dxO6HHO5Du5Ftj6b2FZfdETMc0MP9u
lSh5RbZ0DEKhEvlsvHMcMOOboiqO6IEOPvmUWdbBbgWpLhd2IV2araJs6WUM8D7LyIz3G94k
HvNrmLGxxakArhYY1GmVgG5QKEFLKDDaVYrJhevsl/heY+WvseLNN54z+IrY136bq8TjJsIZ
jfKSxDgzaNKQGZ2iQ2e1Xl/+bI117jqzRcchyW4RWSZYtudj0yaFBxSk3Q2m2+iI2RV1CGgc
FSmU2Q5AQpQX/qsht/AU4PJEFNXz7cY2DhvYvsWxfC3Br61U6FljNYxIspxeqLtmvJEsbo/w
sAcnU0Qy/NQQ8VXIvD+dilEUy2vVKbrYLOkyafIx7uJlYHFn48Mr3GddlfhaYFEeRBI5Lnli
2oUVnmOaA+74IZ5hXRO4JArR5gjcMkJxYizQLT0WGGxoO0LtESyf97CGgMMcxgo8JMPFJlCM
rFPoIbwdE0WU2V8LvmyHwblswMC907XTaU8hVoDntAYE4zMzz7wsdxVYw3XO1Fuz4/XK5XM0
3P/inrW0hkXBY+Bmr3+/fcGCysBLa+NpqIS0XbMxu5V1xLpfHL1TxtfaEzfjbZnEoAzn2ZHW
hLoUI57uZIQX+y04PA9tN26d276vugUf6v466amFNcpPIFxVkwsEcBnq47jLMyery6FeUgQY
02HPnBZIv1V/5cc+jRdI+xS6bkm1GptnDP0sh9QpQ9+TC6VnrFrD4uenUGMg30CgRJjdlWfE
qgSzXk7hxarDZc0HcFdc6r1aCEikP2yvs9lS1mdkT3GvPUXEp3MU4huCopCvXUvPfayYE61+
H5t1Ssi2J5WCDslyQ/G1mm8IavKxNkXPVZziuKrEAz5KjOVNZpprKeYoJHFmzLqxdXIn93o4
CN+Svro0I8DxYehadmla9bfesaAY+V3mdjLzLrO9kgep/r+0L2tuHNcV/iupeTqnauaM5d1f
VT/Qkmyroy2S7Dj9osoknm7X6Sw3yznd99d/ACnKBAk6M3UfZjoGwEVcQIDE4jndNEHWbHnB
XssyBczj+SqajIstHPdTYuZS6DqNrlGisVxD9fLbs4kw5iPcwVlFpPgeyubX6rDl1mbRaLgv
k1k3ldO1GlPVhXSFhDC8wRkGUiV1uLO5VQiHU2MD+xdbexNrBHSrYI3WNEFheuTKELTS0B96
CPvjk2PQZp1efUGRpMvCMIiRvhAK0vdJ2/+12YabYdhTAjj3CFlndQ1rPSM19j4IFKzjJxBg
1x0rJqK6w8Ub2ITOCJ6SZRTKSjhpRnIeKGOGCkD38iy6cj5SBlPAcA6eulAyssvIjmH93Dyh
Ay78f2dYvCgYyTKmQKcIGiqdPbroHO8uJPKivP16kGFJ3Ei0upG2XDcY78Ku94RRnK/+kKB3
jjaX0Ef9oXWecjlb4C4kvajrZlMV27URj6NYtdpjWUMyOKO8MDtKSL/IHL9nFBYGiYKf01v8
BPVoAfJyeO2SmASCaRsX25l6cUk56M4V6+Hp7fD88nTnyptVjMkrqMHUCdaGxDZZc4tduYUj
hpTBztVhac4z06zqzvPD61emJyVsF6MT+LM1LeUU5NQQAat3Hgwp5ccgwMb2ruWnbpPu9bOC
WQ+vk6p3YgIW+Hh/fXw5GGFjFKIIL/5R/3x9OzxcFI8X4bfj8z8vXjE61p+w6CM3jhMKsWXW
RrAek9xNmKdfwOqn0B005cwVinxnRvvvoNI2RtRbmr+xCwi9R60vyVceLwpNxHfMootjDx2h
yvomzeHmPk99t7JxpZ9tiMeIxUMVz1vu2sWgqPOC5uDqcOVQOKVtGnaUdN/dLp6EvEWAZVsz
Nk8PrFeVXkfLl6fb+7unB9+HaqWutENEn3Y+VCiDULKGlBKrki44h13GJ7Rmu6Q8WPfl76uX
w+H17hYY9tXTS3LFr8urbRKGTkwkvF6v0+KaQMxeRaUQMq86ZlZl+/ZRD3qPS994okiyLsPd
8PySlVOHloPmWnXqVZaEoMb++MGPQ6fiXmVrKpcpcG47VGjrOrdG2VL8KA/K9Ph2UP1Yvh+/
Yzyxnr24sVOTJjbD0+FP+XEA6BxIHOx2WcVrlXJzfOrUX29chb8wbAEYvtUJTvb5BscNiGYc
C8HDL19VQlnKkELyseW6YkPbdMcFseQ4wYw1YFfKGCDpaB3cl8lvvnq//Q77xt7LRPDELLRX
mXF+qdd+OLgFppYhm1QdXXDktmxEIIWul4lVWZrSXSWBcNxtWPahsSXnSiuRnRmCU+V1mNc1
w0C7cWJHw9xfTpaaCmP6q6QxmuymDlmQ80RggMc8MX0u7BEz3p7IKMk+F57QfCcCFjrliU1T
ARMc8F1e8Mq1QcB6wRj4mWcwFsJfMCuWiakUnEqRJzcDzH7seMg3zT71GejQ0+VxzL1+GnjB
TgV5+usF/nW1YqBJoZiE2YEe+eExwjzP6IeEeoeKkv+lARugvqUd4gOxrKPqQ/ECf9mWPl9B
7KMOA7cr0kasY47eph451MYwIxF5bJDZXDqByBFx98fvx0f7BO35CIftE9j9JWHbuHzI8IhZ
VfEVO+hNeIreGf94u3t61KmOnLRdirgVUdh+Jj66HWJVi8WYPn12GE/U6g6LGadGZiicE3w2
m49HTIXnAgx3JGWTTwKPFUFHolg9Gi9g0KZzlFUzX8xG3H1aR1Bnk4kZ6rkD69wNHCKUOYJI
mIIM1NCKpK3obk6jSngC3iuCeMm/KnViMEiZK96RFZ2d0iGmPme+DZ+a4iwhoeQwzB6A+JtY
vF5Yl77Q/Jg8DdficsvxDbzoxSvYPG7a0GBJCE9Wht6tfELaPM7IkS9FHNaxMxJzDAMZVfCV
psqv7mWrMkyM5tSd1yoLhziohP92N9UZe1tlznGCQdm2qxW5sOxhbbhkwSTmIoXbWoWBxcwC
oDxsM7uxS/TBblUgQAPcBawFNY/rofqT3D2dyjikstUacyT2JEOTpL5mAt91iK4AP5RGL2NM
UqUZ1Edhp4jwoIGcXYqI9unIPKw7gB0GSAGt2E4AnA0dAEtlRw9YZiLwWPoBinctA8TYdH5U
v2lPOxjpwjILgf/JCMQpD7XrMDCWK+8ySwbzucKxO2xomgxGYhQYogYs4Coy/Y8VYGEBzFxp
l/s6Wlg/7T4poBXZwsCGny+DQcBbe2fhaDjiBht0EhDiqPmrAnliaGgsGXoEUuvdTMzHZrYB
ACwmk6DtojiYjSGcbwgw5DDM9iHMOmuTuw+nQ8v0MBR2to0Trrmcj1iHJ8QsxYRGVfs/RGxr
ZQA9zCfa0KDP0WywCCruWwAVDEnErlmwIPtvNpxaYeAWFicACPd1EjEnRcczWtV04PyG40iE
cVuKSqRpnFotnQj4ECAYrc3q7mw6bwMKMbcT/nY+aLbgVzYGxZvzghGgFkNvqcWYZ5SgRpqv
TtFibDqRAJOVjvMgFDK3jQBlX4MXQVfAhMD5KibR0K4Kr+2ke7OntjBE58/ALiaz0dhFDNuP
BfK6dekjiPNdnBYlhkJt4rDxpPnRSg3bMbQxSCuUlsm3ojyT7YcTu8ObBERd3ohxs5+xMQ2S
XAxBsiHV6wcLCsz2s4iCVH4VGxaid7/dMwCPunaYTqRNOBzPyPKUoDmbogExpqm+AhgLCiT7
YDC0AEEwIGqFgrEW/IAZmhE6EDCajghgYYVzysISxHDuKhkx46HJtwGwsEp3zrjo/jWaDrxr
zqSbzNDbau8nzdsvgZoe7+NCLSprorJyOB0uPIVysZ2RbDRorUPnX+pDO1yxvQO4iSkzWBz7
dl9YzSqD0Zuq8LTc3xv0Pe6PJJmAhcLKGGqzWqjl4sWcvEq59xxiKLmr3rPJD7uo8ivp0UCi
J5kYu2lpQOUwig4rjfHCwTyggcglzDTQ1bBxPTDDsylwMAxGcwc4mGNsEZd2Xqu0RaZGhohp
UE+HU3ZkJAXUxrrvKORsQX0LFHQ+YmPTdMjp3O51rZInuRUFoyAezL2dU5kPfbsBKJo0HE/G
HA9srtPxYDSAbW2uIhnpZdQx+BN4t5rKmP5WKEdQYGRgRc/67cwj97rc3w0uu3p5eny7iB/v
6asMqDlVDFKZ59nHLdy9jT5/P/55tMSq+cgUKTZZOO5i+vRPjn2pvxxd1hQOnIuUvxdoNvx2
eJDJHuvD4+sT6XqTgg5ebto6zmszYptCxF8KB7PM4ul8YP+2dRkJI0J5GNZzyrkTceVhFWWG
YWiIsF2H0WjgZS3Qx6RKkCuvS5q0ri5rVtPYfZkv9uYcOYMkh25zvO8AMvZr+PTw8PRo3hXy
BKYyndXdGOpgdn10ZxkJ6zQnVEe3omSRELSkoLIBqEvdDaOPZn112XdDHS/cLRCl3GyJJZbb
BinWWJ/J48iasHDdqdAFR1ZrGZb1rdqKvEYzGUyJcjIZTQf0N5XlJ+OhJctPxmPO6k4iFqTo
ZDGsZLIMB2oBRhaAus8BZDocV14FZUJCrqnf9vXGZLqY2rclkxlVOSWE5/qImnL8XCLs3oLC
5CGdDSqbdsFXOxsNRmZn53MzSEpUFg1m/zMri+rxeMimTuzk5MjMPwKSbEB0fhRtp6YQkE2H
I/Jb7CcBybqHkDl1bTOFVIynwwup44UppHbijNm7HmRJPpgHRYBgMuxyHhLwZDILbNhsRHlo
B52ytwfqvNXD2kcMP7OxetZ0//7w8LN7/TCMC2C/Rtssu2njHeg51kaWed0V3o9RN4r1GYL+
YpSwPNIhlbTu5fA/74fHu5991PP/xRSAUVT/XqapNo5S5qPSAvD27enl9+j4+vZy/OMdo77T
U3YxsbVzYoHqqULWUX67fT38lgLZ4f4ifXp6vvgHdOGfF3/2XXw1ukibXY1HrHuoxHSKXdeR
v9uMLvfBSBF++/Xny9Pr3dPzAfpiCwvyRndA+SmCAnrkaiAvDXf3wqw/oIj2VT1ckAYAMp4Q
eWMdTJ3ftvwhYdaN5Wov6iGosp4ry6zcjgaTgeeisTuqpJ41wiCrzikmUVD4HBqTP2r06Xhu
1iMn+Jm1W91pUeLJ4fb72zdDhtDQl7eLSiV2fjy+WeKFWMXj8YB7/FaYMeGRo0FgXn93EJL7
mm3PQJpdVB18fzjeH99+Gmvs1LtsOGI1pWjTmNfaG1TSzOzMABgOqNfwpqmHrKvyptlSMaBO
ZvxVLiKG5P7V6XwX3Q1YKKYjfTjcvr6/HB4OoDe8w2A4G4i8JnSgqQuaTRwQFbsTaxskzDZI
2G1Q1PPZwFnoLgEvoFxme2omkuS7NgmzMexpf6WEiK8YSWATTuUmJA96JoK+6JgoT61q+6V1
No3qvbMtOzgrs2ocJ7P25UbkdD2zDMwKcEKpV7AJPR2BKovq8eu3N3arRJ+jth4FvMQioi3e
5bF8Nh0NzPce+A0cyHj/FGVUL0b01k/CeD9uUc9GQ3NzLjfBjN5oIISPlAuSUWBG8EcA8a7O
oHMj8humm/6emqF/1+VQlAPz8kZB4AsHA/KanlzV02EAn89a0mhtpk7hSDLD1FDMkAalQVjA
CoqfaxEMA3J5VJXVYOKROHUrKqc6e5tbTeiba7qDaR2zOZ2AbwNrtzg5QgwVJy8E5hQ4AYqy
gUVgDG0JXyDTxpsWTkkQ0DjkCOHjezSXo5G58GAjbXdJbeZG6EF0S57AZDc2YT0aB2MLMKMW
X91ANjA1EzZvhcTMjTWGgJn5ygyA8cTMmrCtJ8F8aJha78I8pQOsICPj23ZxJi/GbIhpzbZL
pyQAzBeYhKF+W++4DOUIyvr19uvj4U09CrK84tIO+ENR/NOHuBwsFuzjR/dcnYm1oQYYQPZx
WyLoU61YA/8iT7XhaDKkUaI7litLS+npzG7dZOFEGS3xCPsAsdH8IaKpqmxEpCEKt1YsxVmn
8I3IxEbAP/XEjoqqrX65GVVz/f797fj8/fCDWn7jXdOW3GkRwk5Muft+fGSWSX9+MXg6E+hd
1aI/Hc2VLWvRyb4vfsM0SY/3oF8+HuyrKPTjrapt2XxghaI9bzv3zN4KxloXSERIfNXd1Kua
VNN9M9/p7uh9BNlWZka/ffz6/h3+fn56PcqUYY5+JE+TcVsWNd2rH1dBNLDnpzcQGo4nKxvz
emU44xT9qAaWQW0TxH4yHnlSkiBuzho5SAy9EwnL8SDgb5EQF4z89yWTEdsIlrIE9aZMUak4
qwJZ48KOGcyfKXCnWbkIBgMivvNFlBr/cnhFoY1RfZflYDrI1iZHK4dUHsffNteTMMLwonQD
DN9Mn13W5EjclOZFWRKWgaWAlWkQTOzfNlvroDw3A+QosILM1ZMpy+cRMTLegzteXFZx7eq4
EsqK0gpj8cBmwquhm3I4mBp1fCkFSIRTB0Bb0kAra5wzqSeZ+hHTuLlzXY8Wo8kn+7glxN1y
efpxfEBNEDf3/fFVPcQwh68UCidsrqI0iUQl/WDanXk5uQyIEFyqxJBabFxhzsEBlXKqFR+K
bb8Y0c0GkAkb8h2rMMRclF9GgyGRTSajdLC3Eyt+MBB/OzsfvQDCbH10C39QlzqJDg/PeF/H
bmfJqQcCDqCYhm/HS+OFJ0QpMMcka5tNXGWFsj/ntku6XwympkCqIOQ1OgPtZGr9NrZYAycV
leslZMi5y+B1TDCfkPST3Kf36+jacEiFH+pUpCBp08yAQLZeUnBvHOSCu1wJ/Sd0cE+aI4mN
qzTJrZp6P0IDqMOLUGhcLkZ7C9ZFr6DATbLcNRSUmJxdAfaBAzHNYjoQHFxW7V368rUNViuO
AtNytDBFVQVTjxt12DgINAOygXXtQvqIB/YESMsVdnFLLLrDJWzmCVXYjnovofvabkXaoUeZ
L8oEkpShWEzNFw8J3DsrxkhiAXIV+1SMVMRdS0I663IVNINW2ZnDeOo6+c6YQCvGlYSlw3lY
ppEFRfsZu0n0lPc1R51WFCgbcUJej4M5thpFIxkKkg4zds1NEoesz2KH3FQOe2iuUwfQpnFk
Vw2qOfxqOGlDomXkok/67bu6urj7dnw2MpNrxlxddRlOT0IvbOGEu5H/LCPGiITEEVDTDpsw
xLpKk5/0SGiD3MFoT4QvIpBI7mTsJlvWbHLq8RzVvoq4lZrpLPBTuf2mG93MVW/5O9Pqqg8n
Bh8asZnVkAsBYd3ExEUAoXmj9EHdpgzvQr9AR2pLEzImOqgEdCAssmWSezy5MPH9Gq3hyhDT
tXkeVjADoj0OWt+0l0L/AaUIL1uSe76OqwRWQ1IWYSOIKwkmf8Hl17sXG+OMONFsPE6XHX5f
B6wBokJLX3fTXaEDWwdWB7WPLALubI7cLmIStjM9RBNSb//UmbO+dmu9HAb+dDmpgA17ZXe0
O4DcupzDw8WqnButqJzPR2tHG9YH6HLb6j2Xve0pk0jLElJijDPDWxoNaOzuqEdotz7Jc7My
mPBm3R2RG9DQpvAkK1bYPkWN2z4XUNBD0q7TLXdIKiqMHmhW3wUW1LmT7DROPjo7BZPShTY3
mAH6VTpGnvg5pl6rgBXShJ8noEzgASrwhnjdIULLQejCVzRc0lKkkrndTjUjMQZYJM0hnTIj
VZknSTNd2CTdC08zQLXwFcfoPOhI6Ckq98V8KYO20j7piCepHxcMxYfIEfDeJOYoxH6tcaTT
J6z8biTp0rnxoqFb5MxQdXFBsGcbu2GVD0026C8NWihNEdrHkpRxb52pVQnR9DCR9vJ6KJdE
VPGZC2XxCpsUDb91ewqo5nyXuYHu4y4WFZz3vrSomorbBRpXw+auOP9XQiTSXWHXIP03ZUIy
+xvoBCd7OEI+mly1+bmNoNjH2SY2CZ5/KE5YDdhUCRxoeSFn1NMPLWExHVGHWrur9kOMUWkt
NY60AjHN05YKDTeaTaTDcLoFIatiVqCUA+QiYhFkNcvBlq64UC/0cNuYJ5GJnctgysyiUARh
GQSquGeQQJ1qh/McFN6aCncEeWaUkYYZ4SwrR2f2g0R3TZpgDAHJfQzAtyvunNfYfe2MOII3
kTNwGERFrmCaBlAy6lJU+wmKkFHMRzCQO0l6LZ35NlGWmyKPMScHLPcBbb8I47RoujYoSgqg
3GB2IfiuMOPJ2d2j5B1Yzr7ZkgQkzssJ6p4hEo68cVN7EHVe1u0qzpqCXExahd2VZSDlCjvX
XdkO1wEYEUza4m6dSsi4ai68j5qOR6KF0w4wkfy1H3jQkut0y4p8EqWwd8wZUliINjflqc8c
iT1Nc1PGzmh3ilpUnklQb9DJ7fGXKM/0SHvib1fW1PUIZ7npsO8uphddz6NGHpQr+5wU5k1o
MQg0Ncf7mWAEXYGhcKTEHj/24JPNeDBzV5+6lgEw/LD4nryICRbjthxuKUbFRXDqirJ50K98
MjMim07GH7Gwz7NhELfXyRdm8uTFXKj05NbixaCAYLp1nxiLsTKCYWBtHaV4XsZxthSwcrIs
PIdnPqm/LZVyARekhFK5TXTeQSoy+ifzUYJoJH0RDGoHTN7sSNSwGa+ykHQXfqJS4mo+hxdM
EyZfPB6U9aNxr3W6xqoymNpwCuJTaQfU1D0+U5Oh8QkmYuPj/cvT8d54RcmjqiCBABWgXSZ5
hJGDrdDABMuexlYFKrBE/emXP46P94eXX7/9t/vjP4/36q9ffNVj432YVnYg9OfotiNh3GLl
uyzOrJ/9K0bfpALLW7CEj/t8oijCouFuRbtIJ/FqW8du3VpBjTFu6bkmNKHViEWF7sq+jqBg
4/RCnewru3G9SvSp4ZTrMef7g2qNrz/dmEumB83H5J2h57+yZW9p5ZsgWzhNZh+20zPmdb6r
YTzXJRu9WuzQ6b+bEOPaULm56io1FKPXepqp4H/nhgYVwnxXiczZiJvri7eX2zv5VGzfbdfm
QxT8wAwLIFwtBZGVTwiMFkijoQNKukiwlnUZRoytwlgHs6RVdrgNnG7NMhYNi101lbCixUjO
22zYbcp87Kmk9zZsVXMKSxP3nl/wJxeUywT362WbNkmZxvuTsaxh8sQEgdyim+t6thgamloH
rIOx+fiNUBo6CiFd+gvOwMoNOJiYocHxF15nW5XWaZItaY54BHUxGvk4s9J+Cv7OY/ON0IQi
W/NjSGpzF5nbC4Ci+fcMQic7X2CSQ/4lnRB3QqPn5nGLpBxLLGg6A/yttI6I37qSAINL+7F1
HrHr3ArIppyPjt8PF0q2IJYeO4EGHQ3spRojlNRs51cyXLcwGF+8b4atKU53gHYvGjO4vwaX
RZ3Aqg3JQ4JG1nG4rZKGYxNAMmrpSdmBTlWyA6Spztc9duse/6W6x766KZGMmu5HX8LZ00j7
RE6C+byMyA0h/nZrPE1RtgxFuDH4aBUnNUpH1kf2YCAOuaxEPYEMo9KFo3br7Ofardk3hAyd
HsRTE5+dHn/+oL7PtB5Szj8FslQjmgRzk/AKyl52hUWtV/WwZSXPZdOPuQXht0GPlfPRZY3x
LaueuNriDR6snxvvAlK0VuR+BRQ1TEDD9qKKV5gnJFlxeyZPUvXdpwpXQ+trJQAHliOzGYQG
myNjodwVIjFqtOhCUUVk2oMk/wzcOmFfAHXNeF2Jdn4JfcbS6PQLf+twwvP26Rr/pW74e/wv
RR77VxbOmeAed/lhiveYysLmYwrWLmXWvaJkIygmadwinpjqYZBljJly48FDpXEeVjdlk5gR
Xwi4Fem69uGSHBRgkPrwN6HBRUf3bw88s4tPNMttAtJVjiHDctFsK8+lQ5QXjbW4jYNe4uBg
9jxfrsSZ0lfbouHePMS2KVb1mGwHBaM7BFolgJAoACoPAyEo4MtTceOBwU6OkgpFFvjHHFaO
RKTXAuT3VZGmxTX7dUYpVIu5BWqQZHEjwqK80WJueHv37UAkjzzGBdplYvFMrTzQWBmnq09V
GP0GCtTv0S6SYs5JytGzWhcLfOwxh+lzkSYxYYBfgIzl59topdmMbpxvUFl4F/XvK9H8Hu/x
/3nDd2llcceshnIEsrNJ8LfO6RIWUVyKdfxpPJpx+KQINyjMNZ9+Ob4+zeeTxW/BL+YqPpFu
mxVvLC8/wMej8obhX1r8PDcC6grq9fB+/3TxJzcyUuag3EyCLn2hVxCJpghmsFYJxAECQRmO
SDMcjErasknSqDIDAlzGVW6OtnNB02Qlf89UhRu9iut2s13HTbqkRXugr/hGgJqVrPF5T3Xb
4AHyH4tTxKtkJyprUTKDaugLSR1Kho6Z2OKM60meGi3AD71CyBIy0HoNtuMRccAguNmIswKi
JKbjMMHMTTd6CzP0Yvy1zXyYqbcd6jhs4biXLYtk5K147MV4P8CM2WRhFh7MYuQrYwXwskrx
D0aUiA0ASfs1G9ttAJPFtdRywfhI2WDonX1ABRQl6jBJfE3x/j4mhW8iNd6aRQ0e8+AJD576
+ufbIRq/8H4Yf1tBSHgJlZBw9u1IcFkk87aiHyNhWwrLRIi3qiK3+4mIMAaZjI0v2BOAvrOt
CrZwVYB6JjgRvie5qZI0NS8kNWYtYstItMdUcczbLmqKBLot7NsVmybfetJikkE5330QUy+T
ekN7j0eydUONa5+7WSva6yvzECDXPCrQ1uHu/QVdXZ6e0YXPOGkv4xtyTOFvEAivtugvyUhe
+gCNqxpUZpg2LFGBcsCLCE2F5ieRrJa7fVEaQUdgHsQg7W9AZYkrgfoCsadVimAbZXEtjQSb
KjGvFLk7AA3zCDJ9nSCOXhcVm6RZk5SiMWZqg9f3IGVFcQ4fgRoDyrsgSIPKJIjI4RCdQYFs
lqZLQXOlrkC2QLVEXXuzt+mikeZF6OsTxZs4LUmyCQ6tPueX31//OD7+/v56eHl4uj/89u3w
/Zm8hfVfnxYiKhPeG6MnQi/h8xS1WKFdZsI5GBhthZdRcZ1j1Apm/k10G4sqNUZUKrwSiSJd
nOLghXGbFzl5KPCQnb988RSSWJhGYFWpr+ip78BX7KzXvfbZNW5faK/VyGm9llddMzbdxM4Y
P/jR4u0LCI7brfnYKhFRpO5mjA2ndYTTxiMRzGBufsFQU/dP/3389eftw+2v359u75+Pj7++
3v55gF4c7389Pr4dviL/+fWP5z9/USzp8vDyePh+8e325f4gvRRPrKlLjPXw9PLz4vh4xMgk
x/+97WJfaZE4lAIzatAtisEJXqLCYm5gTgzBmaP6EtODRgLRqPtSLhB2TnoK2JhGM1wdSIFN
+OqRNyMw+f3AmjcommIFpxMlMPJqsQOj0f5x7SMi2oeBbnxfVOquyLyiqG9yOKH26GMlM5aW
V/hcQBNPOERYk0MlWX3R3wW8/Hx+e7q4e3o5XDy9XCiWY8yvJMY7JJK5lYCHLjwWEQt0SevL
MCk3JGcwRbhFYCltWKBLWpm3ZScYS9jrWE7HvT0Rvs5flqVLDUC3Brz2dElBVhFrpt4O7i3Q
z7y8hnao1qtgOM+2qYPItykPJI8eHVz+wx0Z+pu2zQYkCqe+PhOKund4/+P78e63fx9+XtzJ
Nfj15fb5209n6VW1s3ZBJnErp0nkemjEp5E74WuOVffoKqoFU2+d8UqZHqFttYuHk0lAtDJl
bfP+9g1DB9zdvh3uL+JH+e0YzuG/x7dvF+L19enuKFHR7duteUWnqw45iw09v6afjC6wAelR
DAdlkd7QAD39vlwndTCcuzswvkp27KBuBDDInfNtSxnrEEWXV2caw6W7IMLV0oU17qoPmaUc
h27ZtLp2YAXTRsl1Zt/UzLeCBOxJ1ag3ycY/sBHoG83WnRJ85djpfbC5ff3Wj5kz26CX+Nve
ZIL5Du7jdopSh704vL65E1SFoyEzRwh2G9mzTHiZist4uGTGUWE43ePUThMMIjOdk17UbFPe
Uc+iMQNj6BJYxtJtwf3oKotIfDy9ITZmcr4TcDiZcuBJwBx3GzFihqfOONtJjWxAClkW7kl2
Xaom1MI5Pn8j9ir99nY3D8CshHf9NBXXK9CBzzI3kcWg5Z9hm6FApVWnIXDL1w13zWGg3eFU
RvF2VSv575m6Ot7HsLaqVLmp7HkYM82AMmoPihryp4dnDBBCJWLd4VUqmpipzfeS2aHnY+4G
rC/L9Q+gmzNsAp8+9Sqpbh/vnx4u8veHPw4vOiwt13+R10kblpwAFVVLmeZiy2M6rmR3UuEE
HUaGhDsAEOEAPyco/sdokGxq8YY8qM0lTEH3+/GPl1uQ21+e3t+Oj8xBhSEUBbvaZHDFj/gY
Eqllp10V3WOqJ/E0wosPLl3EbG2Ea94IshNmRQ7OkZzrpMFj2W5aksX5znr45OaaWyvxDpWz
6yT3+Y4bhDp7aM6Z4hh09aT0NNXVYC9OtlcylonwPGc7hI1lbe+jqzeMkNtjrfBMDh5k37/Y
yHAw5hu6CmMfvOsc1zxi41wqHDBdHw2JQa2Vu/PdNguc6QMmhPbZAJ7okmzdxOFHHAgIlTcA
e24iWj39syi8TtuHNKuYgQ5DOMfPty0dGOvY3Y5yFrO0WCchev1+hLcNjUgnh4wCiBjtalGE
tZQQ+MPQQ4kC+flv4wqFrNBtU2/CLTu7or7JshjvneVNNfo4uWc0htT9U6pbrxd/olPE8euj
Cm909+1w9+/j41dT7lZPssjmw8s0qftrdd7u4S/UrQdimeSiumlLqKxZfeqD8/oOo0ok0bQt
zQALHaRdgm4NZ2xlxNJBIx5RAUm+picXxsFIWMa4TECq3MWVadWifetB4MxDvP6upJudeQ9h
kqRxrrGG0W0VJXwkD/j0LG7zbbaEVjlDRPnEYMbm6H39w8S2ea0b2KJ9gtJ++YSwyUAsIKBg
SpdY2CpFg12tYZs025ZWQPUf+Nk7oFgVIyaFHi1veCsOQsI/BnYkoroG4ZHvIeBh8kiXpkTl
CemvmblOlq6aFxqav63XwYqKiox+cYf6goc6CFidlGtCT7KvbvdL0dv3UWgUc/AxSz1mqVG6
ZcglmKPff0Gw/bvdm2lTOpj09ypd2kSYA94BRZVxsGYDC95BoEexW+8y/GyuqA5qezp12NO3
wdCY97sEUXjgYxbeaQrW9mNe0SrMEFkXaUEyzZlQrDYwhnQZbsgP6WnSyEScGbnnroswAU6w
A5GiqgR5npOW76b/lgKhtU9LuAPCyZ13JPOWhqmo8IVoI9UGig1t8jKugFdphLo5Ofx5+/79
DcMFvh2/vj+9v148qFeA25fD7QVmxvh/hj4BhVH+brPlDczhp2DqYGq8f1BYk5OYaOgGvsqL
Nf/SRKvyvAhSItacFUlEmqzzDEdmfiqLQyHQLd5j64549AxlTqV6naq1YyyptFjSXwxn6ddd
U2QJ5W3pl7YR5H4Jo0yBAsJZomdlQqLkw49VZLSDXoUVXn42lbHMtmE9xOONGtoWeaMNyyiU
mjwj2fwHZ0/ToehhJIHTH2zsVImb/QjGTgH0Mk7PNSPgFM6RwCkKKyRpxz+4jEy6LwPrq4PB
j8CtqN7m+DG+egAdDH8Mh0450NiD6Q+PSVPXBe67anS6S81jr0Z/3MKQFpTxH779XYvUXIZw
WhLuUGJkDoNtFcvPYr02u6qm/7yfqSO72cs3KaqYtKsR8oah3qRRMvIiKy8yPYfchlkZmQ9y
JhLEJem1WstdeR33l0L9W6UWhyX0+eX4+PZvFZX14fD61TVakcLspYyfTYROBQ4xwzKr4Skf
wxa0lRRE0LR/eJt5Ka62aCA87nc2HFZofObUMDYY100ugH2csVYnFE52QEMlyJYFyGxtXFVQ
gJPKVA3w3w6zUXZeod068Q5jf4V4/H747e340CkNr5L0TsFf3EFfwYEZt9eiyj8Fg2E/JLhk
QWmt0Z05oxavsYhiTDgB561gGaXqfq1cNNA8NRONeVzbGNl6W+SmqYfcfdcCNrDqYFlIRz3T
ZtqEmyP0l8dAjpi8szze6UUbHf54//oVH9iTx9e3l3fMmUJeUjKBOjHodTSIIPl0aiKsYWqb
eG82ejJ8c5WUGXocnmmkq7Azf+llFSnqwOhdrqOlD95e7VdoJnRJdI7tsmYt2i5DgKOV9q5d
VsVlTAwX/tIA2p+pbGwc7bozgujrMHgD7s9432ByTVNGlHBYBHWRqxPWaqgqItEIn9DbW2gr
4uu9W8E1J970mmQTbbPSGuTuC4E3prG4tJb0qbFd1pbrBm+j3EZPuI87jRdIW1PNVWBoHh19
0PLEEHiU4cylwPl0r2oVFk3l8LjKC+mDhoKeiKJO67HtVU5T1Ym08POieHp+/fUCc8O9P6u9
t7l9/Eq2USkwZhYwgYJ3YCJ4NDrZxp8GFInnRLFtAGx4x55rXtlMAke4f0c2YK6ykxUNg6YD
i81exnEXBF3du+A79Wnh/+P1+fiIb9fQi4f3t8OPA/xxeLv717/+9U8jH4A0OMMq11I4sKXB
a2AA2ybe09sBLS38jRbtxQUiLujTa27UpbjjON5L9oz2T9u8BpUMlDKlxzvbVw3/vxUjuL99
Ax0GOMAd3mCRycdeoEqHOxPOSUy/kdixoMmMeqpUT1Dhlp9KitCfmBdlK7+wsrYt+pngR0qk
PFaMw0aVQGWn1cNjYkCTKEJjq0txr0+c1QFlsklJT3QB+AdmGWTc6wTPQrtvDr3mPR5CRq2w
erwsigYXsVG1qf7UxWrVVc6tkHAD89+3fZIKrlPR+IupPugxdge2zkVZbwpyGlkoVF3bsNzC
QLEGFKqFJSxNDP9bFSsMxkM+juBixyrQ9EmSBCLPi0agGbMqyb699MSwdDQZ06g7MieK9FK9
KBSKinNTg1aWsZOuVEucNtyiNkTPvNl0cI9dN46hWqjKydY30HKDcFq6sfQ5tG5BpFLNx6Gz
VyqjwmtEI+CsK1v7rvS0sygNdytsdM9XnUnTx1CQOyaK00Z4jM0FRuz14KQte6cwOVzz5fh6
9x/Cwkwtqjm8viGLx2MsfPrP4eX268Gw89+S810FHZBs3vQpO8UiMD9TQeO97LgzXhaZ5Iwe
X/ReIEEJ0REnQIhAwVHNjnn72VGfGkKy7n0OrxBFhVIdP6KSFjWQaos3TLZQTaiqK+hhrK6s
Pg1+YF60XpKoQMKWrBA+DWe9M0M4WYVfRg0fw0PfJrFavV7s6G2xifedkHjaZgjvLgWUwT43
rJqqDssbp/QlIJpiz+/iWCa5wZchX7X2HYYEdobjtJ69vDb11YNewStQQpxiFV78+yRYNS7q
ZYAWg73mo7evWVZJjlG8WCak0oIlVQaiS2yBe3/SEwNOmlUSp5Fa6hzTiLugRGQj9UwV6/Ps
MfXm16N4zwPztc3Ht8Iskq71XA+g/7UFUvMJ7Mq88ZZA4EAhnNT23LuXVt3yky9+7Kjo6qiK
oYYe7dxRNSMqwzmO1ku9KGtmSV3j3oiKUG5vcogpaXSZ4P1JUfFuytYN1P8Hx+R3eAcmAgA=

--GvXjxJ+pjyke8COw--
