Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A611B69A277
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Feb 2023 00:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjBPXhz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Feb 2023 18:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjBPXhz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Feb 2023 18:37:55 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB10166D6;
        Thu, 16 Feb 2023 15:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676590673; x=1708126673;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yfEQqdaB8WA1seANKH8umeZHyRoa3AVBxVgJTkCHKVM=;
  b=MpFl8N50ODCw7soZUC0gFako92fXqaLBBsM+4oQobdbvxgZojnJCSH8M
   aDd2wr75OQ/Xt6McoWVaQResHB1GGvkwKuzcFs88d1y7J3hJGRe1rIo4Z
   of9PYbf5qSa9vkw/gLpEQ8ERVTRTGjLBHrhxlUmJMOiR6vaTyhVBm8kwB
   n59VvJTDg6ei0N2S8YvG8eR0nXon7sCihF9PT4QhLAIcSiwaXdhpoZgPw
   VyrI1X1KwBl6LgfUZ6Iwd+S+raZBNp0582mZlXx//tsDApUagsNEX6HaI
   Zgr/DOeyLJj52mDWEwe9GNdpaENkZKHiMUZ3mvHTb0T37W9WTglRFpNEu
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="333224476"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="333224476"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 15:37:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="813173910"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="813173910"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 16 Feb 2023 15:37:50 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pSnp0-000Ax4-06;
        Thu, 16 Feb 2023 23:37:50 +0000
Date:   Fri, 17 Feb 2023 07:37:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Jarkko Sakkinen <jarkko@kernel.org>,
        keyrings@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 07/12] tpm: Add full HMAC and encrypt/decrypt session
 handling code
Message-ID: <202302170740.7jtAnH0N-lkp@intel.com>
References: <20230216201410.15010-8-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216201410.15010-8-James.Bottomley@HansenPartnership.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi James,

I love your patch! Perhaps something to improve:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on char-misc/char-misc-next char-misc/char-misc-linus herbert-cryptodev-2.6/master herbert-crypto-2.6/master linus/master v6.2-rc8 next-20230216]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/James-Bottomley/crypto-lib-implement-library-version-of-AES-in-CFB-mode/20230217-044329
patch link:    https://lore.kernel.org/r/20230216201410.15010-8-James.Bottomley%40HansenPartnership.com
patch subject: [PATCH 07/12] tpm: Add full HMAC and encrypt/decrypt session handling code
config: m68k-randconfig-c44-20230212 (https://download.01.org/0day-ci/archive/20230217/202302170740.7jtAnH0N-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/1d4f519aa756ba5ed684fb2a2f9ad6e1fb91bdb5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review James-Bottomley/crypto-lib-implement-library-version-of-AES-in-CFB-mode/20230217-044329
        git checkout 1d4f519aa756ba5ed684fb2a2f9ad6e1fb91bdb5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/char/tpm/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302170740.7jtAnH0N-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/char/tpm/tpm2-sessions.c:337: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * tpm_buf_append_hmac_session() append a TPM session element
   drivers/char/tpm/tpm2-sessions.c:855: warning: Excess function parameter 'authp' description in 'tpm2_start_auth_session'


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
