Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21AD67A6B9
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jan 2023 00:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbjAXXM3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 Jan 2023 18:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjAXXM3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Jan 2023 18:12:29 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1934B89B;
        Tue, 24 Jan 2023 15:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674601947; x=1706137947;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=05NIQy/Nf+AD6/tSG16DUrJCefVYRfbu8Z3GoAS6jlA=;
  b=Vz1q6szOtINBb8LhwgKOl/SpK3dPm7H5qZsuAdItHsDGjcTSbVwnkvuO
   RZJoy0XCweE2udHbJOoC64PyEHrX6+LGpqCVZWg76944Us9aF976nhyyK
   lRAICvdpyx9VmdoBlqqEKwQyQuHCBL8lDHXlFzJCS4LNO9tVdr8IdHIcY
   z6ICIsHC5yUi/lqzFbFMy+Mwwh9XgQPJ01HZWeFDy7TTVRPZl1YiJ4LxP
   AUnfpPwu6TKkJnkkM8cRk9vosyqK5GNtkUR3sCvfkwRI/sZTB6sc4LsdY
   +UkW5F5pvw7xMWb30ua4w5moxK+1jrHyucGLzpLcOxbMZhmwHeAcboh3V
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="306099374"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; 
   d="scan'208";a="306099374"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 15:12:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="655603153"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; 
   d="scan'208";a="655603153"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 24 Jan 2023 15:12:25 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pKSSm-0006rA-1l;
        Tue, 24 Jan 2023 23:12:24 +0000
Date:   Wed, 25 Jan 2023 07:11:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Jarkko Sakkinen <jarkko@kernel.org>,
        keyrings@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v2 06/11] tpm: Add full HMAC and encrypt/decrypt session
 handling code
Message-ID: <202301250706.deGvd0yq-lkp@intel.com>
References: <20230124175516.5984-7-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124175516.5984-7-James.Bottomley@HansenPartnership.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi James,

I love your patch! Perhaps something to improve:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on char-misc/char-misc-next char-misc/char-misc-linus zohar-integrity/next-integrity linus/master v6.2-rc5 next-20230124]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/James-Bottomley/tpm-move-buffer-handling-from-static-inlines-to-real-functions/20230125-020146
patch link:    https://lore.kernel.org/r/20230124175516.5984-7-James.Bottomley%40HansenPartnership.com
patch subject: [PATCH v2 06/11] tpm: Add full HMAC and encrypt/decrypt session handling code
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20230125/202301250706.deGvd0yq-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/dc0fc74718b4a786aba4a954233e8ab3afdcc03c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review James-Bottomley/tpm-move-buffer-handling-from-static-inlines-to-real-functions/20230125-020146
        git checkout dc0fc74718b4a786aba4a954233e8ab3afdcc03c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/char/tpm/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/char/tpm/tpm2-sessions.c:1184:5: warning: no previous prototype for 'tpm2_create_null_primary' [-Wmissing-prototypes]
    1184 | int tpm2_create_null_primary(struct tpm_chip *chip) {
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/char/tpm/tpm2-sessions.c: In function 'tpm_buf_check_hmac_response':
>> drivers/char/tpm/tpm2-sessions.c:831:1: warning: the frame size of 1132 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     831 | }
         | ^
   drivers/char/tpm/tpm2-sessions.c: In function 'tpm_buf_fill_hmac_session':
   drivers/char/tpm/tpm2-sessions.c:579:1: warning: the frame size of 1132 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     579 | }
         | ^


vim +831 drivers/char/tpm/tpm2-sessions.c

   676	
   677	/**
   678	 * tpm_buf_check_hmac_response() - check the TPM return HMAC for correctness
   679	 * @buf: the original command buffer (which now contains the response)
   680	 * @auth: the auth structure allocated by tpm2_start_auth_session()
   681	 * @rc: the return code from tpm_transmit_cmd
   682	 *
   683	 * If @rc is non zero, @buf may not contain an actual return, so @rc
   684	 * is passed through as the return and the session cleaned up and
   685	 * de-allocated if required (this is required if
   686	 * TPM2_SA_CONTINUE_SESSION was not specified as a session flag).
   687	 *
   688	 * If @rc is zero, the response HMAC is computed against the returned
   689	 * @buf and matched to the TPM one in the session area.  If there is a
   690	 * mismatch, an error is logged and -EINVAL returned.
   691	 *
   692	 * The reason for this is that the command issue and HMAC check
   693	 * sequence should look like:
   694	 *
   695	 *	rc = tpm_transmit_cmd(...);
   696	 *	rc = tpm_buf_check_hmac_response(&buf, auth, rc);
   697	 *	if (rc)
   698	 *		...
   699	 *
   700	 * Which is easily layered into the current contrl flow.
   701	 *
   702	 * Returns: 0 on success or an error.
   703	 */
   704	int tpm_buf_check_hmac_response(struct tpm_buf *buf, struct tpm2_auth *auth,
   705					int rc)
   706	{
   707		struct tpm_header *head = (struct tpm_header *)buf->data;
   708		struct tpm_chip *chip = auth->chip;
   709		const u8 *s, *p;
   710		u8 rphash[SHA256_DIGEST_SIZE];
   711		u32 attrs;
   712		SHASH_DESC_ON_STACK(desc, sha256_hash);
   713		u16 tag = be16_to_cpu(head->tag);
   714		u32 cc = be32_to_cpu(auth->ordinal);
   715		int parm_len, len, i, handles;
   716	
   717		if (auth->session >= TPM_HEADER_SIZE) {
   718			WARN(1, "tpm session not filled correctly\n");
   719			goto out;
   720		}
   721	
   722		if (rc != 0)
   723			/* pass non success rc through and close the session */
   724			goto out;
   725	
   726		rc = -EINVAL;
   727		if (tag != TPM2_ST_SESSIONS) {
   728			dev_err(&chip->dev, "TPM: HMAC response check has no sessions tag\n");
   729			goto out;
   730		}
   731	
   732		i = tpm2_find_cc(chip, cc);
   733		if (i < 0)
   734			goto out;
   735		attrs = chip->cc_attrs_tbl[i];
   736		handles = (attrs >> TPM2_CC_ATTR_RHANDLE) & 1;
   737	
   738		/* point to area beyond handles */
   739		s = &buf->data[TPM_HEADER_SIZE + handles * 4];
   740		parm_len = tpm_get_inc_u32(&s);
   741		p = s;
   742		s += parm_len;
   743		/* skip over any sessions before ours */
   744		for (i = 0; i < auth->session - 1; i++) {
   745			len = tpm_get_inc_u16(&s);
   746			s += len + 1;
   747			len = tpm_get_inc_u16(&s);
   748			s += len;
   749		}
   750		/* TPM nonce */
   751		len = tpm_get_inc_u16(&s);
   752		if (s - buf->data + len > tpm_buf_length(buf))
   753			goto out;
   754		if (len != SHA256_DIGEST_SIZE)
   755			goto out;
   756		memcpy(auth->tpm_nonce, s, len);
   757		s += len;
   758		attrs = *s++;
   759		len = tpm_get_inc_u16(&s);
   760		if (s - buf->data + len != tpm_buf_length(buf))
   761			goto out;
   762		if (len != SHA256_DIGEST_SIZE)
   763			goto out;
   764		/*
   765		 * s points to the HMAC. now calculate comparison, beginning
   766		 * with rphash
   767		 */
   768		desc->tfm = sha256_hash;
   769		crypto_shash_init(desc);
   770		/* yes, I know this is now zero, but it's what the standard says */
   771		crypto_shash_update(desc, (u8 *)&head->return_code,
   772				    sizeof(head->return_code));
   773		/* ordinal is already BE */
   774		crypto_shash_update(desc, (u8 *)&auth->ordinal, sizeof(auth->ordinal));
   775		crypto_shash_update(desc, p, parm_len);
   776		crypto_shash_final(desc, rphash);
   777	
   778		/* now calculate the hmac */
   779		hmac_init(desc, auth->session_key, sizeof(auth->session_key)
   780			  + auth->passphraselen);
   781		crypto_shash_update(desc, rphash, sizeof(rphash));
   782		crypto_shash_update(desc, auth->tpm_nonce, sizeof(auth->tpm_nonce));
   783		crypto_shash_update(desc, auth->our_nonce, sizeof(auth->our_nonce));
   784		crypto_shash_update(desc, &auth->attrs, 1);
   785		/* we're done with the rphash, so put our idea of the hmac there */
   786		hmac_final(desc, auth->session_key, sizeof(auth->session_key)
   787			   + auth->passphraselen, rphash);
   788		if (memcmp(rphash, s, SHA256_DIGEST_SIZE) == 0) {
   789			rc = 0;
   790		} else {
   791			dev_err(&auth->chip->dev, "TPM: HMAC check failed\n");
   792			goto out;
   793		}
   794	
   795		/* now do response decryption */
   796		if (auth->attrs & TPM2_SA_ENCRYPT) {
   797			struct scatterlist sg[1];
   798			SYNC_SKCIPHER_REQUEST_ON_STACK(req, auth->aes);
   799			DECLARE_CRYPTO_WAIT(wait);
   800	
   801			skcipher_request_set_sync_tfm(req, auth->aes);
   802			skcipher_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP,
   803						      crypto_req_done, &wait);
   804	
   805			/* need key and IV */
   806			KDFa(auth->session_key, SHA256_DIGEST_SIZE
   807			     + auth->passphraselen, "CFB", auth->tpm_nonce,
   808			     auth->our_nonce, AES_KEYBYTES + AES_BLOCK_SIZE,
   809			     auth->scratch);
   810			crypto_sync_skcipher_setkey(auth->aes, auth->scratch, AES_KEYBYTES);
   811			len = tpm_get_inc_u16(&p);
   812			sg_init_one(sg, p, len);
   813			skcipher_request_set_crypt(req, sg, sg, len,
   814						   auth->scratch + AES_KEYBYTES);
   815			crypto_wait_req(crypto_skcipher_decrypt(req), &wait);
   816		}
   817	
   818	 out:
   819		if ((auth->attrs & TPM2_SA_CONTINUE_SESSION) == 0) {
   820			/* manually close the session if it wasn't consumed */
   821			if (rc)
   822				tpm2_flush_context(chip, auth->handle);
   823			crypto_free_sync_skcipher(auth->aes);
   824			kfree(auth);
   825		} else {
   826			/* reset for next use  */
   827			auth->session = TPM_HEADER_SIZE;
   828		}
   829	
   830		return rc;
 > 831	}
   832	EXPORT_SYMBOL(tpm_buf_check_hmac_response);
   833	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
