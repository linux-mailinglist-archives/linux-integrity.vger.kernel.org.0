Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6DCE12325B
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Dec 2019 17:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbfLQQZJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 Dec 2019 11:25:09 -0500
Received: from sonic313-14.consmr.mail.ne1.yahoo.com ([66.163.185.37]:44444
        "EHLO sonic313-14.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728188AbfLQQZG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Dec 2019 11:25:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1576599904; bh=XXbsZ6x7oCUtuMbA7hTYdSczrsHj0vKBbZ5akyoiWO0=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=nG2OB6vFelDkfgnzOVCPkahp0K2d/6u2NtZPLmFTKUoleJQEqxXUTxUxVTD8/Adjip4LhK61CalJvuhRb4eqSdvIacHWhgxK2SYdVpEVneesSRLd6VIE/KitpCK21f6hOwlHeWmxL+Ay4+N7vupRwjNsn5pRZoQ4xuyhqEIpz5UX0EKoFBGuNA4RZI3WB0qks5/zgFAIRMyaNbXMe/IJmkSxrHYSCBDSXMaW7fQ1XGzdWZdAr20dSJv4I8djj3omjmP0rbBwxa2VBqn9UmELk1RbEQGEdStbEt61oYGfzfGuJ71mdwX4rdSFBg0Grim0jdJAPdETRL46bRzH0EBnUA==
X-YMail-OSG: a.q_p24VM1mDT9SGTpl1K38O95phTQ2l0z3Lb_tdbJuUuJ_TH0n4P.4K8Ifc3Yo
 4Hq9bhTbaDUD8e0E1wIv5TtYmp08G77nIthX9KZ6WIxlhqIMIIsLMyWQheAcGg3mzTdqBs29u8FZ
 w5IUcQBGdU3nXxDCesTb6swz5VG5JnOd6fbmmR_e5MfShiLJUp2w_4XEOPHU2FP3jt5ngucmXg8O
 BncNeBLFzyGaXXRZ09xrysSUSZkftL3RCWxQB4kMOzGSfqnmt.US9MuRIZYWMd6v2SGA1.D2Vyyr
 wOCTQ9vFhK8ISecfT9OIp1ANxAvEWkWvdKBy.xjQdmcUwn5ZFoTk4jUhqy6ZlQOUtaKGUf4C.qfL
 2W085yxYGNKid7Mv2U69ETzj21p8Fc5JmFhKo7zCPqoWxu0YCb70VLTZHcvHrt8EhGl8HipuIOIu
 Zar3vq__XmZcPyKW2TZOWl32H66ljZsi5z5S1uK9ZWk3TbowWwnFwxRjfcKfiZqgFY_LNOltW5rN
 koNtEVLCqhMvOCYAgGXSANlEq6qbMB8ZJ9BTvHX2MYIw1mPvQ84n637sZHa04acDmgKgwMT1cb7R
 pAf9W0GmpNurgvei2pFNSP35xOE643ReLzloIB8hGFJepVPWd2GJSWYXjcXKNDqrpOpgn_oJWGsZ
 2QxQ7ct0SRMRg_xeeZsxxDkpQxmJafB3HDwqvOllm3KXt9s4xZm9Kmi24Je24nTU8PThGqnMu1sX
 2wLlNJiVI_8.fra.x0DNbSH8cij5zqK50ThaWYdBTmyJ9eFWdzztIiZUIA0biQ_6FXsfLTX_fQpL
 vvIM5HddkGg7FXWGeUJBv.Mk2klUuDhLC9qVge_o4VwiC0KqUaf7A2Bqo9_bnx6ToY84MRElgOFD
 wCN7NRpVhtgAF_Oflc9j2G6axp6mXhSzCxHkJEykTxrl73P2d25U7.f52Fw6H87wVF4oNOp7AbBS
 QouDTW2Gcxehx4J7Lct_jxjahBLgHrVXu179TJhHhlZd6h19MLP6BvP8k7WfszJILsOJYf.WRcVK
 ODPq3mLQVTl75TUs3MJYR7.jXjLHzIOEIBwyHv7LfZoUNX9iNPeurX3GwzJJgmiDwMbBMxOT812l
 NMw2p9fdaTo.B8.TdPG0L_aKLN7Vqg6znChtSaVmThiNWrcjw7KG0oW2oEoiZr0xrhE796iZS3aE
 MJQcw6CZjLaE74t2_WYrdyW2AW3UX3Q9SupWMBHUJ77PDl5xncvxpSMj4Uu9iRYuYmMuLHAtgmy0
 6DQZd7qbphhJMZc_4_gsCTfN1MYzBbW6q6bTjX6GYi9FaMwQY0fMMyHeQverpJ1WFAq0hrJrZNBo
 aaBsZv12kgrzo3n7Cctl7JQPoKWPAFsM7VlvfS6hodzYY6VYjlFwyiijHYvwfZULbn4MDbtLB2Ho
 rlgRKSBJQw_ekRtKco_k0ao18PAlfyCi2yuzYZtuywCNeLYQPMMrM_fUWkqrOig--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Tue, 17 Dec 2019 16:25:04 +0000
Received: by smtp427.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID a20bd7134ac93420f683ed18562ccd23;
          Tue, 17 Dec 2019 16:25:02 +0000 (UTC)
Subject: Re: [PATCH] integrity: Expose data structures required for
 include/linux/integrity.h
To:     Florent Revest <revest@chromium.org>,
        linux-integrity@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, revest@google.com,
        allison@lohutok.net, armijn@tjaldur.nl, bauerman@linux.ibm.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20191217134748.198011-1-revest@chromium.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <e9e366d3-6c5d-743b-ffde-6b95b85884a2@schaufler-ca.com>
Date:   Tue, 17 Dec 2019 08:25:01 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191217134748.198011-1-revest@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.14873 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/17/2019 5:47 AM, Florent Revest wrote:
> From: Florent Revest <revest@google.com>
>
> include/linux/integrity.h exposes the prototype of integrity_inode_get().
> However, it relies on struct integrity_iint_cache which is currently
> defined in an internal header, security/integrity/integrity.h.
>
> To allow the rest of the kernel to use integrity_inode_get,

Why do you want to do this?

>  this patch
> moves the definition of the necessary structures from a private header
> to a global kernel header.
>
> Signed-off-by: Florent Revest <revest@google.com>
> ---
>  include/linux/integrity.h      | 37 ++++++++++++++++++++++++++++++++++
>  security/integrity/integrity.h | 37 ----------------------------------
>  2 files changed, 37 insertions(+), 37 deletions(-)
>
> diff --git a/include/linux/integrity.h b/include/linux/integrity.h
> index 2271939c5c31..15a0d5e91737 100644
> --- a/include/linux/integrity.h
> +++ b/include/linux/integrity.h
> @@ -18,6 +18,43 @@ enum integrity_status {
>  	INTEGRITY_UNKNOWN,
>  };
>  
> +#define IMA_MAX_DIGEST_SIZE	64
> +
> +struct ima_digest_data {
> +	u8 algo;
> +	u8 length;
> +	union {
> +		struct {
> +			u8 unused;
> +			u8 type;
> +		} sha1;
> +		struct {
> +			u8 type;
> +			u8 algo;
> +		} ng;
> +		u8 data[2];
> +	} xattr;
> +	u8 digest[0];
> +} __packed;
> +
> +/* integrity data associated with an inode */
> +struct integrity_iint_cache {
> +	struct rb_node rb_node;	/* rooted in integrity_iint_tree */
> +	struct mutex mutex;	/* protects: version, flags, digest */
> +	struct inode *inode;	/* back pointer to inode in question */
> +	u64 version;		/* track inode changes */
> +	unsigned long flags;
> +	unsigned long measured_pcrs;
> +	unsigned long atomic_flags;
> +	enum integrity_status ima_file_status:4;
> +	enum integrity_status ima_mmap_status:4;
> +	enum integrity_status ima_bprm_status:4;
> +	enum integrity_status ima_read_status:4;
> +	enum integrity_status ima_creds_status:4;
> +	enum integrity_status evm_status:4;
> +	struct ima_digest_data *ima_hash;
> +};
> +
>  /* List of EVM protected security xattrs */
>  #ifdef CONFIG_INTEGRITY
>  extern struct integrity_iint_cache *integrity_inode_get(struct inode *inode);
> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index 65377848fbc5..2d5e69ab4646 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -77,25 +77,6 @@ struct evm_ima_xattr_data {
>  	u8 digest[SHA1_DIGEST_SIZE];
>  } __packed;
>  
> -#define IMA_MAX_DIGEST_SIZE	64
> -
> -struct ima_digest_data {
> -	u8 algo;
> -	u8 length;
> -	union {
> -		struct {
> -			u8 unused;
> -			u8 type;
> -		} sha1;
> -		struct {
> -			u8 type;
> -			u8 algo;
> -		} ng;
> -		u8 data[2];
> -	} xattr;
> -	u8 digest[0];
> -} __packed;
> -
>  /*
>   * signature format v2 - for using with asymmetric keys
>   */
> @@ -108,24 +89,6 @@ struct signature_v2_hdr {
>  	uint8_t sig[0];		/* signature payload */
>  } __packed;
>  
> -/* integrity data associated with an inode */
> -struct integrity_iint_cache {
> -	struct rb_node rb_node;	/* rooted in integrity_iint_tree */
> -	struct mutex mutex;	/* protects: version, flags, digest */
> -	struct inode *inode;	/* back pointer to inode in question */
> -	u64 version;		/* track inode changes */
> -	unsigned long flags;
> -	unsigned long measured_pcrs;
> -	unsigned long atomic_flags;
> -	enum integrity_status ima_file_status:4;
> -	enum integrity_status ima_mmap_status:4;
> -	enum integrity_status ima_bprm_status:4;
> -	enum integrity_status ima_read_status:4;
> -	enum integrity_status ima_creds_status:4;
> -	enum integrity_status evm_status:4;
> -	struct ima_digest_data *ima_hash;
> -};
> -
>  /* rbtree tree calls to lookup, insert, delete
>   * integrity data associated with an inode.
>   */
