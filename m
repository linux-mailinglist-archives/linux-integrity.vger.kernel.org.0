Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851D5648D34
	for <lists+linux-integrity@lfdr.de>; Sat, 10 Dec 2022 06:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiLJFRM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 10 Dec 2022 00:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiLJFRM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 10 Dec 2022 00:17:12 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0A862E89;
        Fri,  9 Dec 2022 21:17:10 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id w15so7133004wrl.9;
        Fri, 09 Dec 2022 21:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GpsjaZk9EL+Zisbm1FT7YhXE+6Nr47bM9VNs+l/TT+o=;
        b=GsjL5ECYVfZDn20lKc2mDUHyX382h2cyctHfeOOCj4w2roGOdWP9mraJEU2viN6BDN
         IcJlEuZ+WDqrLl/q7ILspzH8aq86vx/BqavgoCcf8svdMZzeQJ+igl6SqWnmAMtQQHX2
         CK7U+netPEUyckqgQzpWgUl65GHBdfCbwzcOoVD/XpSyilJeRGJ5zV0YCmk47m+OiqOp
         VBn92mIdC58D0DCvbBwKMgYQiUItsoUiJBflnM0ucnEBjiB8tXyenUba5a2yUuqsGXvb
         99Sb+DosH3RVeQcSltEOljHt5LprvT0TZz8YL1EtG19VIbYPcb7aMuYawsj8Rr847xHX
         hH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GpsjaZk9EL+Zisbm1FT7YhXE+6Nr47bM9VNs+l/TT+o=;
        b=1V0zOwG94i4EvJJyQ124zIn75tWcm9hU+ZmzqjrphW142cQwM3pMaKwsShMey66kuX
         ExTQbgRKJMy0GIrKYe9B7DdrBfFk1x8S9SBM12TFWOcR3tGR3CErtAj4+Py+HmujQdxI
         aaX4OfryL0C531Ub3Y2z0a+pjMRI4y/Yb8Ogsbl2WXfhIgmIvhEv44BUy12yt83rZ+cc
         wrqvtq66mRq0ovrbq8SJWhcgzSqKXjyR/wSamp7jx36sr2X8ReOko/mN4fY1m3i9ugMz
         sUZKDmTHA37TSJ8VzV1YDJv0xZSJo4SYXemZD5+C4N0TZWNcyTguwKfaX9Q2zFSBRwK5
         yGMg==
X-Gm-Message-State: ANoB5pkymnZLH3uVY9j216vi7mcv9T0hELrVQMBIOJ7kaHo8l7hqBIxe
        J1MtUF4vqucbnIrfEhDKKmMcT+gpduUopg==
X-Google-Smtp-Source: AA0mqf4LXLgeQNcWNACMzMkyWMG+/yeMhG5WV4ytD0Hk4rVG9sxYLhiwRvXlaP3URemmMlpo+SiOhg==
X-Received: by 2002:a5d:6daf:0:b0:242:7491:3be0 with SMTP id u15-20020a5d6daf000000b0024274913be0mr12022424wrs.67.1670649429037;
        Fri, 09 Dec 2022 21:17:09 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id x9-20020a5d54c9000000b00241cfa9333fsm2924088wrv.5.2022.12.09.21.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 21:17:08 -0800 (PST)
Date:   Sat, 10 Dec 2022 08:17:04 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        Ard Biesheuvel <ardb@kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org
Subject: Re: [PATCH 06/11] tpm: Add full HMAC and encrypt/decrypt session
 handling code
Message-ID: <202212101224.wxWpB9ou-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209160611.30207-7-James.Bottomley@HansenPartnership.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi James,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/James-Bottomley/add-integrity-and-security-to-TPM2-transactions/20221210-001335
patch link:    https://lore.kernel.org/r/20221209160611.30207-7-James.Bottomley%40HansenPartnership.com
patch subject: [PATCH 06/11] tpm: Add full HMAC and encrypt/decrypt session handling code
config: x86_64-randconfig-m001
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

New smatch warnings:
drivers/char/tpm/tpm2-sessions.c:294 tpm_buf_append_salt() warn: possible memory leak of 'secret'
drivers/char/tpm/tpm2-sessions.c:890 tpm2_start_auth_session() warn: possible memory leak of 'auth'

Old smatch warnings:
drivers/char/tpm/tpm2-sessions.c:331 tpm_buf_append_salt() warn: possible memory leak of 'secret'

vim +/secret +294 drivers/char/tpm/tpm2-sessions.c

af8e86ceddca73 James Bottomley 2022-12-09  258  static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip,
af8e86ceddca73 James Bottomley 2022-12-09  259  				struct tpm2_auth *auth)
af8e86ceddca73 James Bottomley 2022-12-09  260  {
af8e86ceddca73 James Bottomley 2022-12-09  261  	struct crypto_kpp *kpp;
af8e86ceddca73 James Bottomley 2022-12-09  262  	struct kpp_request *req;
af8e86ceddca73 James Bottomley 2022-12-09  263  	struct scatterlist s[2], d[1];
af8e86ceddca73 James Bottomley 2022-12-09  264  	struct ecdh p = {0};
af8e86ceddca73 James Bottomley 2022-12-09  265  	u8 encoded_key[EC_PT_SZ], *x, *y;
af8e86ceddca73 James Bottomley 2022-12-09  266  	unsigned int buf_len;
af8e86ceddca73 James Bottomley 2022-12-09  267  	u8 *secret;
af8e86ceddca73 James Bottomley 2022-12-09  268  
af8e86ceddca73 James Bottomley 2022-12-09  269  	secret = kmalloc(EC_PT_SZ, GFP_KERNEL);
af8e86ceddca73 James Bottomley 2022-12-09  270  	if (!secret)
af8e86ceddca73 James Bottomley 2022-12-09  271  		return;
af8e86ceddca73 James Bottomley 2022-12-09  272  
af8e86ceddca73 James Bottomley 2022-12-09  273  	/* secret is two sized points */
af8e86ceddca73 James Bottomley 2022-12-09  274  	tpm_buf_append_u16(buf, (EC_PT_SZ + 2)*2);
af8e86ceddca73 James Bottomley 2022-12-09  275  	/*
af8e86ceddca73 James Bottomley 2022-12-09  276  	 * we cheat here and append uninitialized data to form
af8e86ceddca73 James Bottomley 2022-12-09  277  	 * the points.  All we care about is getting the two
af8e86ceddca73 James Bottomley 2022-12-09  278  	 * co-ordinate pointers, which will be used to overwrite
af8e86ceddca73 James Bottomley 2022-12-09  279  	 * the uninitialized data
af8e86ceddca73 James Bottomley 2022-12-09  280  	 */
af8e86ceddca73 James Bottomley 2022-12-09  281  	tpm_buf_append_u16(buf, EC_PT_SZ);
af8e86ceddca73 James Bottomley 2022-12-09  282  	x = &buf->data[tpm_buf_length(buf)];
af8e86ceddca73 James Bottomley 2022-12-09  283  	tpm_buf_append(buf, encoded_key, EC_PT_SZ);
af8e86ceddca73 James Bottomley 2022-12-09  284  	tpm_buf_append_u16(buf, EC_PT_SZ);
af8e86ceddca73 James Bottomley 2022-12-09  285  	y = &buf->data[tpm_buf_length(buf)];
af8e86ceddca73 James Bottomley 2022-12-09  286  	tpm_buf_append(buf, encoded_key, EC_PT_SZ);
af8e86ceddca73 James Bottomley 2022-12-09  287  	sg_init_table(s, 2);
af8e86ceddca73 James Bottomley 2022-12-09  288  	sg_set_buf(&s[0], x, EC_PT_SZ);
af8e86ceddca73 James Bottomley 2022-12-09  289  	sg_set_buf(&s[1], y, EC_PT_SZ);
af8e86ceddca73 James Bottomley 2022-12-09  290  
af8e86ceddca73 James Bottomley 2022-12-09  291  	kpp = crypto_alloc_kpp("ecdh-nist-p256", CRYPTO_ALG_INTERNAL, 0);
af8e86ceddca73 James Bottomley 2022-12-09  292  	if (IS_ERR(kpp)) {
af8e86ceddca73 James Bottomley 2022-12-09  293  		dev_err(&chip->dev, "crypto ecdh allocation failed\n");
af8e86ceddca73 James Bottomley 2022-12-09 @294  		return;

kfree(secret);

af8e86ceddca73 James Bottomley 2022-12-09  295  	}
af8e86ceddca73 James Bottomley 2022-12-09  296  
af8e86ceddca73 James Bottomley 2022-12-09  297  	buf_len = crypto_ecdh_key_len(&p);
af8e86ceddca73 James Bottomley 2022-12-09  298  	if (sizeof(encoded_key) < buf_len) {
af8e86ceddca73 James Bottomley 2022-12-09  299  		dev_err(&chip->dev, "salt buffer too small needs %d\n",
af8e86ceddca73 James Bottomley 2022-12-09  300  			buf_len);
af8e86ceddca73 James Bottomley 2022-12-09  301  		goto out;
af8e86ceddca73 James Bottomley 2022-12-09  302  	}
af8e86ceddca73 James Bottomley 2022-12-09  303  	crypto_ecdh_encode_key(encoded_key, buf_len, &p);
af8e86ceddca73 James Bottomley 2022-12-09  304  	/* this generates a random private key */
af8e86ceddca73 James Bottomley 2022-12-09  305  	crypto_kpp_set_secret(kpp, encoded_key, buf_len);
af8e86ceddca73 James Bottomley 2022-12-09  306  
af8e86ceddca73 James Bottomley 2022-12-09  307  	/* salt is now the public point of this private key */
af8e86ceddca73 James Bottomley 2022-12-09  308  	req = kpp_request_alloc(kpp, GFP_KERNEL);
af8e86ceddca73 James Bottomley 2022-12-09  309  	if (!req)
af8e86ceddca73 James Bottomley 2022-12-09  310  		goto out;
af8e86ceddca73 James Bottomley 2022-12-09  311  	kpp_request_set_input(req, NULL, 0);
af8e86ceddca73 James Bottomley 2022-12-09  312  	kpp_request_set_output(req, s, EC_PT_SZ*2);
af8e86ceddca73 James Bottomley 2022-12-09  313  	crypto_kpp_generate_public_key(req);
af8e86ceddca73 James Bottomley 2022-12-09  314  	/*
af8e86ceddca73 James Bottomley 2022-12-09  315  	 * we're not done: now we have to compute the shared secret
af8e86ceddca73 James Bottomley 2022-12-09  316  	 * which is our private key multiplied by the tpm_key public
af8e86ceddca73 James Bottomley 2022-12-09  317  	 * point, we actually only take the x point and discard the y
af8e86ceddca73 James Bottomley 2022-12-09  318  	 * point and feed it through KDFe to get the final secret salt
af8e86ceddca73 James Bottomley 2022-12-09  319  	 */
af8e86ceddca73 James Bottomley 2022-12-09  320  	sg_set_buf(&s[0], chip->ec_point_x, EC_PT_SZ);
af8e86ceddca73 James Bottomley 2022-12-09  321  	sg_set_buf(&s[1], chip->ec_point_y, EC_PT_SZ);
af8e86ceddca73 James Bottomley 2022-12-09  322  	kpp_request_set_input(req, s, EC_PT_SZ*2);
af8e86ceddca73 James Bottomley 2022-12-09  323  	sg_init_one(d, secret, EC_PT_SZ);
af8e86ceddca73 James Bottomley 2022-12-09  324  	kpp_request_set_output(req, d, EC_PT_SZ);
af8e86ceddca73 James Bottomley 2022-12-09  325  	crypto_kpp_compute_shared_secret(req);
af8e86ceddca73 James Bottomley 2022-12-09  326  	kpp_request_free(req);
af8e86ceddca73 James Bottomley 2022-12-09  327  
af8e86ceddca73 James Bottomley 2022-12-09  328  	/* pass the shared secret through KDFe for salt */
af8e86ceddca73 James Bottomley 2022-12-09  329  	KDFe(secret, "SECRET", x, chip->ec_point_x, auth->salt);
af8e86ceddca73 James Bottomley 2022-12-09  330   out:
af8e86ceddca73 James Bottomley 2022-12-09  331  	crypto_free_kpp(kpp);
af8e86ceddca73 James Bottomley 2022-12-09  332  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

