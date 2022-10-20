Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83051606705
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Oct 2022 19:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiJTR3T (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 Oct 2022 13:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiJTR3T (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 Oct 2022 13:29:19 -0400
Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AAF11DA93
        for <linux-integrity@vger.kernel.org>; Thu, 20 Oct 2022 10:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666286955; bh=dmxcPBytFnzLe2E1XkMxdUFlJa/2N5M2eqaiKWidtac=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=C0lepjEpFmkrbwpYKS+VffZclpTvCu93vj3ccZzFokYK//xEVOLHoX9+E2aq4LTKjLJe5Uvdi492twyMgv5bCx0fpAM/2M2mplaEDGOCnp0Eez439gIcW4aYTrdca4uC5o661XswIQdt7bjEyjjmr4E/DfCDCEQXzZHPma1j4+3kyS1xuWPoSeCbi3U7LpC9YWaI+SB8pd9cD9G3dS77nwrYs/kRBRdSdmot0mYBd/2mH3Xgf83AS686IsGdEO5hnv7cxulJvR/ykA+6M4yRHr7ZNwgqYCDKJV34Rk8S2iPOFmRgdKwfRhO/cZDc+Rhut6uCfa3r0fqzmEw3UG8sYA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666286955; bh=Ui7N1xG9MaFLSYbU8D1IaQOLBc89Dc4vTJjS4Y8o1Ha=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=AhW4Ccd8fCtQ1aCtARGg8JlaXmI77M43y7cDS95VXlN9tW7iX8qcwVpSukKl4Wpm6HUuw1zTO907jZUp84n6pBeCDTDldpQ0lVicmqHvqFoW8cwwx13OvhsajARx5JRY4B7pNZEdak78i/GSilhu+EySzeorz7zRWtaW9UeEjbulq8+BJFiqbMZq0neHH+HmO7V5aaETeO7jtTCCzTDq+KRByROjm+os/0Brwy3m3ATCyr81M741Tbouu4xpZQj9B2Z7juPBT0v96EmlkEHygadKjlVfs/eAtonlaYcmmAFM4gn/aXJ53uGM+Do+ryh2zQPOHNE6dIEdc6lPnwXvFQ==
X-YMail-OSG: QzXv1.4VM1nMOB56LwM.gs1QCkNGwW4frHEvwEe7SFpE_c8qp8D7CfsLoDLh0St
 WPw4Pbqbor5voeQcFrqj6k_TFq3Psxa18vFiThtBA8MktEswMfOCR_LzZK8Lz937M3STM5AKLP7h
 5wulNuoLXZisINjdonlgaVJTOdRT0dNg1HCVL0CP7gzlVKmkXYai21knVu3i.2_cNDN3K3Q7WqgC
 xjr15g3GnKr.U3PpVRsU0TkBYzokqdozG0TB.Xha7OGw3tbw5k2UTfqSCQ2NZVzzekocIQD7RQPr
 cVFezSj4VlXSWyE.Vqyxnemcgo594YMggthbTUIMUuhnuL7xbNyq1f9Kq6K18m0S8FSS30Al4KyA
 1.ujWo_hBXEW2F1c_SiHx2es844hS0ATODfiLrJ.uafHD0sg20EuGG81olBPTpAXdU4yVy0p1csJ
 UyVRRJYzWu9nzbO1N8OPuA9AYgsBGfOF8O8adFf3MI4cV8zCfYX9abRg8qa2luNCdlbNl3.Gc9cZ
 USLMK.0d13UekvLpy906EiRlZ2A6eMi9SDgLh.YcjPxFR_90v2GRxLhxvbLptlZdX_RiULm8cw2l
 IB9SS30d6XW2LfZdWdJhsK6eMRFvjtDX5q1gO3QZ8gtrexDE8Aw72g2G3D9jolPFdWD1iI2DryG_
 kcq.cRwrdjja.UlI3t888vn_A9FOUwrBlW2z4y8GPNSdc48LLVod8fvLNlkJOI54FWF_4tI1MxX_
 .TjAQkOUcLQ2ZpzyFt6UptVReVQQXw7vPVfhDwx.YXZMkozvfr3kLvYuORMq8jyGTqps7Rmd832l
 PZFxeLid7HRuEjGmlAdyP0fBGUHTEcCWFEwcA0p.e61xfPFBsa2O7GDTJ_wl2HsyaF3XKcixuqBb
 mZu8g0Kanemxna9dMlYdAZrtUE7w2Ee8lsr4hRRcEu_KgLNCz04a1g7Znk662aGF3I4OwcKefdkS
 pKVM0LCnsawivJXpjqRULPvGNtZrjEz4JKScGCpgj_oZylOq_pcJhvUXtTJI3OPWXTbvjeB0x4pu
 7kyaQki_TMOIlYfM2oXc3pxIkBztKozEzosO7HF0Yr8LzsrRDBagtrj6sZmwfOx2MC5yhPy0lgpL
 9UXQpdqVMBFTzGsWxKPUAfxCeUpVLqaRxpVxqhAAnTXhFz8ATDltHLcv0O4lGugAT1Q9q_dQ5ncV
 GK5fYiIgIYfS2LQzW6.vr9OsmzJWvx9jQVisH1p6v9OvxV8V6yWDTWCIo6IDc9VdcJTyRuC8wKFV
 N7s35JJ.wWvkk_0mEJKBN094xB2gK4vNHBTLEVD9CKRu.8yMeSKLCY5eTNtkR_L2XHfK9r.8.7t1
 i3m0GVz5OHx.qv6TEtLilehorrIrrGjvsf83dMX0V.Oz0Rydq3X9DOOxRuaqECrdRUjY7fL3a5Jp
 JJ8pajiCbFIrNEOu9Ngq7XjReZph7nBgmJJv1VT8gpW2n0ePuv2H2sd22W1hnfacaAuJysWdORV_
 l3LHpAlmsQqa2gduI_fl3d5k5QAtoLu5K8vOCnOpcP3dxNTUHIrLAm8FzYF6n3EYt2J2h0L2RYhv
 JYkcf4YDYHNL2q14RlE2VrktZkkChUnNal4G6xU1GTZHepOSSJFpseEOHQENkB8dbalcv15x_P_e
 K8.vlGR1DIUTZ31u_5dS4gE_tdyt.5602T3hWIXQ3tpR8UEGSakUUOjqvgrFb50rvLpNr5XzS6qE
 lTmJ9VSO8xDkf3chY_jEzH5s1eRupLvU.N3Qq9A0OnQNfdAKkdtuT52LZ0RDmM6txss7q3BiFpWp
 0IJ44xB9qb8UE_iaBcpwYmgvgpZr2LYTu1TbID0ZcJ2d85AKLx6Qf_wJ3Lg4abdnKs8ULobzxWE_
 6FDji2OCk5C1BfeRT2Kuqe5O4uCtRdcJx.IC_pCJxA.v5jF_mjH4nEIh7dAbFJ6sNPnGf9BMzKkt
 kE_BRjBvieoySIHtqr4LTLqT8zX6QwopuZq9cgcBxBb0qCXWxsIQGIAxPE2tFv49cwG9JvgXDLTQ
 LbyaiIt028pAPIJHECoXrc7s4WQIdVHkNrDeaXYSsum5Kbk.LbfYVoTHq.oeIKipBpp.0ywL5WEC
 ZfkRewjJlAb1.FQcBI4tX7m.S_x_EONA4Lgm5mWbDb9GoQ6Kvve.VDktXPD14BGIzYBqxasQDvCj
 ooupwuASsR2FbHQFcxMy6PWesWu.4d6kwYZrRb.1UqTFP9DS9B1kJjVEdgH69S6OJkzXN2Mv1Yv5
 Mt6CpQVbLGWzKzq5jqfLJbMa8ToYfuoUvCUHQKsE5fJW1uaLJtA--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Thu, 20 Oct 2022 17:29:15 +0000
Received: by hermes--production-gq1-754cb59848-dxw7w (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID da65b2d877440166aa7461bdf22645bd;
          Thu, 20 Oct 2022 17:29:09 +0000 (UTC)
Message-ID: <34084e9a-b4c0-95b7-1132-ca95294c8063@schaufler-ca.com>
Date:   Thu, 20 Oct 2022 10:29:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 6/9] fs: Introduce file_to_perms() helper
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Mimi Zohar <zohar@linux.ibm.com>
Cc:     John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        KP Singh <kpsingh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org,
        casey@schaufler-ca.com
References: <20221013222702.never.990-kees@kernel.org>
 <20221013223654.659758-6-keescook@chromium.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20221013223654.659758-6-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20754 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 10/13/2022 3:36 PM, Kees Cook wrote:
> Extract the logic used by LSM file hooks to be able to reconstruct the
> access mode permissions from an open.
>
> Cc: John Johansen <john.johansen@canonical.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: linux-security-module@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/fs.h               | 22 ++++++++++++++++++++++
>  security/apparmor/include/file.h | 18 ++++--------------
>  2 files changed, 26 insertions(+), 14 deletions(-)

Smack uses its own definitions for MAY_SOMETHING. Making
AppArmor's values global is going to clash. If you want to
do this there needs to be a grand consolidation. It could
go in security/lsm_hooks.h. I can't see anyone other than
Smack wanting MAY_LOCK, so I can't say the concept really
makes much sense.

>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 9eced4cc286e..814f10d4132e 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -993,6 +993,28 @@ static inline struct file *get_file(struct file *f)
>  #define get_file_rcu(x) atomic_long_inc_not_zero(&(x)->f_count)
>  #define file_count(x)	atomic_long_read(&(x)->f_count)
>  
> +/* Calculate the basic MAY_* flags needed for a given file. */
> +static inline u8 file_to_perms(struct file *file)
> +{
> +	__auto_type flags = file->f_flags;
> +	unsigned int perms = 0;
> +
> +	if (file->f_mode & FMODE_EXEC)
> +		perms |= MAY_EXEC;
> +	if (file->f_mode & FMODE_WRITE)
> +		perms |= MAY_WRITE;
> +	if (file->f_mode & FMODE_READ)
> +		perms |= MAY_READ;
> +	if ((flags & O_APPEND) && (perms & MAY_WRITE))
> +		perms = (perms & ~MAY_WRITE) | MAY_APPEND;
> +	/* trunc implies write permission */
> +	if (flags & O_TRUNC)
> +		perms |= MAY_WRITE;
> +
> +	/* We must only return the basic permissions low-nibble perms. */
> +	return (perms | (MAY_EXEC | MAY_WRITE | MAY_READ | MAY_APPEND));
> +}
> +
>  #define	MAX_NON_LFS	((1UL<<31) - 1)
>  
>  /* Page cache limit. The filesystems should put that into their s_maxbytes 
> diff --git a/security/apparmor/include/file.h b/security/apparmor/include/file.h
> index 029cb20e322d..505d6da02af3 100644
> --- a/security/apparmor/include/file.h
> +++ b/security/apparmor/include/file.h
> @@ -218,20 +218,10 @@ static inline void aa_free_file_rules(struct aa_file_rules *rules)
>   */
>  static inline u32 aa_map_file_to_perms(struct file *file)
>  {
> -	int flags = file->f_flags;
> -	u32 perms = 0;
> -
> -	if (file->f_mode & FMODE_WRITE)
> -		perms |= MAY_WRITE;
> -	if (file->f_mode & FMODE_READ)
> -		perms |= MAY_READ;
> -
> -	if ((flags & O_APPEND) && (perms & MAY_WRITE))
> -		perms = (perms & ~MAY_WRITE) | MAY_APPEND;
> -	/* trunc implies write permission */
> -	if (flags & O_TRUNC)
> -		perms |= MAY_WRITE;
> -	if (flags & O_CREAT)
> +	u32 perms = file_to_perms(file);
> +
> +	/* Also want to check O_CREAT */
> +	if (file->f_flags & O_CREAT)
>  		perms |= AA_MAY_CREATE;
>  
>  	return perms;
