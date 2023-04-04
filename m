Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10A46D5645
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Apr 2023 03:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbjDDBt5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Apr 2023 21:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjDDBt4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Apr 2023 21:49:56 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD6FB4;
        Mon,  3 Apr 2023 18:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680572994; x=1712108994;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gN+KKoPKHIZ18Kz3GcxyRGQuAOc/wMIGMeJHrc6u2Fc=;
  b=Jm3pVbfjh3Ll6Wfb9Ly9NooJ+Tte8DD8/jnyRrlyvtKeReWXbvuD202s
   8qTxhTSEIOhbtuT82gVHaIu4xZL4XvMn0oZKuSVY5JiTjavsRW5pRYJZi
   GQdlS1J+KUy6FVu+A2wDsSldPHhfdL9AKk3kXPi9+vn+qKTNkQ16nducD
   Jgl84rj1ma4z2Rg6YI7t3VvRPbugRGz8VdTq62DY41IIGTw6GlRcsElGQ
   mfJz3QiwH+HX9mA5qw9SCSG8vSdLcPAUvAj6jaFml/uO2c9F7cgYdBFq+
   Y/6Xq/qE1zlpx/z3q5dHt9u4xwgbKVZFMrQn2p05Xi6p2Q9RyOzRCmzmM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="326081487"
X-IronPort-AV: E=Sophos;i="5.98,316,1673942400"; 
   d="scan'208";a="326081487"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 18:49:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="686181689"
X-IronPort-AV: E=Sophos;i="5.98,316,1673942400"; 
   d="scan'208";a="686181689"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 03 Apr 2023 18:49:52 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pjVnz-000P1G-2c;
        Tue, 04 Apr 2023 01:49:51 +0000
Date:   Tue, 4 Apr 2023 09:49:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Jarkko Sakkinen <jarkko@kernel.org>,
        keyrings@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v4 08/13] tpm: Add full HMAC and encrypt/decrypt session
 handling code
Message-ID: <202304040920.8D4b7ebX-lkp@intel.com>
References: <20230403214003.32093-9-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403214003.32093-9-James.Bottomley@HansenPartnership.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi James,

kernel test robot noticed the following build warnings:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on char-misc/char-misc-next char-misc/char-misc-linus herbert-cryptodev-2.6/master herbert-crypto-2.6/master linus/master v6.3-rc5 next-20230403]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/James-Bottomley/crypto-lib-implement-library-version-of-AES-in-CFB-mode/20230404-055053
patch link:    https://lore.kernel.org/r/20230403214003.32093-9-James.Bottomley%40HansenPartnership.com
patch subject: [PATCH v4 08/13] tpm: Add full HMAC and encrypt/decrypt session handling code
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230404/202304040920.8D4b7ebX-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/2fbef78e6bdb1d5385ac75a5a5e750fed42e53e2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review James-Bottomley/crypto-lib-implement-library-version-of-AES-in-CFB-mode/20230404-055053
        git checkout 2fbef78e6bdb1d5385ac75a5a5e750fed42e53e2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash drivers/char/tpm/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304040920.8D4b7ebX-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/char/tpm/tpm2-sessions.c:337: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * tpm_buf_append_hmac_session() append a TPM session element


vim +337 drivers/char/tpm/tpm2-sessions.c

   335	
   336	/**
 > 337	 * tpm_buf_append_hmac_session() append a TPM session element
   338	 * @chip: the TPM chip structure
   339	 * @buf: The buffer to be appended
   340	 * @attributes: The session attributes
   341	 * @passphrase: The session authority (NULL if none)
   342	 * @passphraselen: The length of the session authority (0 if none)
   343	 *
   344	 * This fills in a session structure in the TPM command buffer, except
   345	 * for the HMAC which cannot be computed until the command buffer is
   346	 * complete.  The type of session is controlled by the @attributes,
   347	 * the main ones of which are TPM2_SA_CONTINUE_SESSION which means the
   348	 * session won't terminate after tpm_buf_check_hmac_response(),
   349	 * TPM2_SA_DECRYPT which means this buffers first parameter should be
   350	 * encrypted with a session key and TPM2_SA_ENCRYPT, which means the
   351	 * response buffer's first parameter needs to be decrypted (confusing,
   352	 * but the defines are written from the point of view of the TPM).
   353	 *
   354	 * Any session appended by this command must be finalized by calling
   355	 * tpm_buf_fill_hmac_session() otherwise the HMAC will be incorrect
   356	 * and the TPM will reject the command.
   357	 *
   358	 * As with most tpm_buf operations, success is assumed because failure
   359	 * will be caused by an incorrect programming model and indicated by a
   360	 * kernel message.
   361	 */
   362	void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
   363					 u8 attributes, u8 *passphrase,
   364					 int passphraselen)
   365	{
   366		u8 nonce[SHA256_DIGEST_SIZE];
   367		u32 len;
   368		struct tpm2_auth *auth = chip->auth;
   369	
   370		/*
   371		 * The Architecture Guide requires us to strip trailing zeros
   372		 * before computing the HMAC
   373		 */
   374		while (passphrase && passphraselen > 0
   375		       && passphrase[passphraselen - 1] == '\0')
   376			passphraselen--;
   377	
   378		auth->attrs = attributes;
   379		auth->passphraselen = passphraselen;
   380		if (passphraselen)
   381			memcpy(auth->passphrase, passphrase, passphraselen);
   382	
   383		if (auth->session != tpm_buf_length(buf)) {
   384			/* we're not the first session */
   385			len = get_unaligned_be32(&buf->data[auth->session]);
   386			if (4 + len + auth->session != tpm_buf_length(buf)) {
   387				WARN(1, "session length mismatch, cannot append");
   388				return;
   389			}
   390	
   391			/* add our new session */
   392			len += 9 + 2 * SHA256_DIGEST_SIZE;
   393			put_unaligned_be32(len, &buf->data[auth->session]);
   394		} else {
   395			tpm_buf_append_u32(buf, 9 + 2 * SHA256_DIGEST_SIZE);
   396		}
   397	
   398		/* random number for our nonce */
   399		get_random_bytes(nonce, sizeof(nonce));
   400		memcpy(auth->our_nonce, nonce, sizeof(nonce));
   401		tpm_buf_append_u32(buf, auth->handle);
   402		/* our new nonce */
   403		tpm_buf_append_u16(buf, SHA256_DIGEST_SIZE);
   404		tpm_buf_append(buf, nonce, SHA256_DIGEST_SIZE);
   405		tpm_buf_append_u8(buf, auth->attrs);
   406		/* and put a placeholder for the hmac */
   407		tpm_buf_append_u16(buf, SHA256_DIGEST_SIZE);
   408		tpm_buf_append(buf, nonce, SHA256_DIGEST_SIZE);
   409	}
   410	EXPORT_SYMBOL(tpm_buf_append_hmac_session);
   411	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
