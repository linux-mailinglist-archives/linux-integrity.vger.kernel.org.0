Return-Path: <linux-integrity+bounces-6193-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCD3AB5AA0
	for <lists+linux-integrity@lfdr.de>; Tue, 13 May 2025 19:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 526C64610DB
	for <lists+linux-integrity@lfdr.de>; Tue, 13 May 2025 16:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65952BE7B1;
	Tue, 13 May 2025 16:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="W4ybK3NA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic307-15.consmr.mail.ne1.yahoo.com (sonic307-15.consmr.mail.ne1.yahoo.com [66.163.190.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA1C28C87E
	for <linux-integrity@vger.kernel.org>; Tue, 13 May 2025 16:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747155582; cv=none; b=ViIAj1ulLy/MyNAldadMj2juK37wtfJSy5N5683ipO/uI3XvK+zzgTfmqNokriVt/pK+VD71QLJjPNRG8NMiwfkBCPER+b+Dc917VF2MQCXmoUY1WHEIpyZx6lBlR8aoGzcSIckiOvQc8T3jW5zHblcFau83CkZPqg132f4Vg+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747155582; c=relaxed/simple;
	bh=FmXOKeRvhaBUvobsSpue9vREcq0xQ12PTTClIWMriE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RJMcuTdzVmr3Kzyn+xQ2WjSeQ31PAk1tMLLoE7XkPgjgmPRJlIBCXariIyUQW0Hwvqpj+UfzDAz4K917hdsMJGGKOJMHFDmEYmqIaG1+POxuzhJQ8MaOxDUwVgDbBQ5khI/QFKiTQvF8X7swcIgluEI3Cq8dB5NWLV2LKYZBGT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=W4ybK3NA; arc=none smtp.client-ip=66.163.190.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747155580; bh=f7yEnpGDfIxqCLkdBSc+JOa9oHhXZWC5oycNI7ZFiLs=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=W4ybK3NAqaSicBWLBAM7zLdUfyIP7hRJ/GPjfpLSm8EhYxIHIBwbxjUtt8EwiT4VjVS/5vRXxz2h05AGBjhVfSQ4nPGT/ahatPG2wP7aDT9m3NJ6HdRNsWb6pioOk1S9dUNZEczvqDq7fXqcw7h2JFnRziNk+krXvwlLoOZxcXozR/FWoWVjy1EnyVPdTKEHGSyTI7VuAhvNGpWBrqLjRzNJIDLEoHdVmxlzXQmeiDleup2blUUPbD1ylxbk7WtoBUQVDmZ1YAEu+V3gpwhnGcjviyDFe1J9eODynIxUmK/vSrOmvfuix2w8MJ/VcnqVNXW3lhVjk7hyXS0+O936bw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747155580; bh=b2GeQGelAzZl0c7r+C89mId1xvVVeot/qChOuEZp3MF=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=UaEFamjvpfNAUHU+oyANNy4cDOR7aDjS5yykPZfJXYhZwZ69ha5JEPURy2DvF05FOqPfo1FDFJH5LB42JzVtF0yUdbKirDXoRLjT1TrKPr9CZzgwF/FQ1GP68hWVZPfBVq5AX9gzndyZVWrsKF0wzLjFO39LaoEROUWXpRUuP8exXxh99YPEl2/Ndmb4IlbuIGd4a8VpCJnQBHaY6GTbRh5p9w9BcAXssofxWz/ELntu9D+DNu7oBL0uV+KfuEOEUjUjzlLoMfsftIv3OpdEsOVsX9XMYWtEg2MslvxCmRhGRqiwifOxDHdBOibw2qjEA4EI2ETorWcwZpxJFHG4hw==
X-YMail-OSG: FMon.voVM1lE2_fOVQIHST4jtaTTSK3.vOMT2cmJQeUWW_QW4Pcw39cN2dJ8Plp
 eHV3tvIglFKdnKxaUI8K._kYbqAotVWQQivhIh37CsTCISiu5QgWcs8u_H4ibSGzI9bmoQuEBnV5
 sZLeFqz6Welu4L1KRzL_uYbnzo.9AYqRP8mVcpQfF_zlFeaQJ0zNjLXGMKiwAG4uY2FfgSOxymKb
 kV6qqZdfYbZ0m.l47n_t3hvOy3UJyj1lMKPPKwp_BJZYYN3AU89WInFiU.dKxfrgVI.0yI.UZcRU
 7iKsD09WtaR.OVzjqO398E9OMURbaAkkCC.WbJ.YAQVc85TbZtLA1y5lZbSkETsqGjIZolORgvWD
 Yxw4nxz4sBro9mTFT4jRX7CkeY3Q5VgZ2D0E68KfZWaVpcqLG7naJ1vyIlnafD8587fyuSXbakHq
 Kv7xdDIesG5uyS4hW0JQFO3Wwx5V8TLdeqHsVEdkEQaHcBvHzHSmiV.3McTZ1vKsCjrk78RHP9pv
 VQih8vos5O49A8GsgJqpnUr3G5BSGULXmF7X50hP0Qjugr73JJpoMJo.pM4L6g3ILrqzvIhBfNV7
 VynGmDFKXsJD55HIERGWEfkp6VIMaagQPBE0EYOlZfKpnTJAZ8kl.cs49vsMQaIHAmLzc_4umuTY
 apiAyYsG3K8sYlS11FWx2CbhRxbl574ZyRHPw5HF7KsrnPtXtqnUOenvefHQRHyQts20o44f1T07
 VAFRGkhJfjTJQDGgLz3.Zuf21JS.WxeaKk8BNof3XG1asl.k98gBEBWp6e_s5_q2zOtrLABI1iom
 t3PmANtmhxiGldy9hFx3ij1mJpgIRK3mpTpoAhEvCLwiN3Oxwop_zjQ3JiQmwF3A2KF62R6g0XVO
 efTGNary1o8LFm8nhwQJTN.Pb9AqkeY8q5vW8lKwxqQCM.P9f4nYQgNnxMgo3j5Y1IAJxJu7RwFm
 Tb7HZs79jbh6lEbOFpUxL6PgAEh24IxK67ufuwv76naapQ46JtcmXF52ONW2RqVwq70OsyWL3LyK
 yLyxxXHDCsbJwYRLOawcYDVgS8aA7PqT6lqkIfRLW9PZN1cxgj5yOEBr1wGDbSxAAncSwyqH8Y.N
 .GTAhbfAWqDfJJbzmcsexey34s0eSPvqLYGi8FvPRGNjtrGq6eiAck_aV3uhI6dkL3aRA8l8R3KF
 1nWhsCC5bJcnexzgI9yyUcf_dBhW4VrcORZuBh3GDNkJMY5YONuLi.McSTZoss6AKtipDi1MEchP
 HMQ5UPeON36fLjX8g7cH.yBnkhXXtyZQK0yfxmyAsRvJDuZHYOzQs7MbKq9g6xgMTeOiE4yz_vMJ
 svk2c6w9wb0wSlOUpRDU5nYVbTVgDjoaIaPawrLUlFnDsFJbyVNEn.ApGoa5bX_1nXhofc4iE.bz
 z.tF6X6Po5SuHhwRSlcxe84FH_r0rfdUXkeG.fbXO2XrilGlfdUzCSWJyY.xrwLyJxXnDR111nva
 KSuQJvhp3.VExEuBUIdMBBVkTkcr1017FzzQ7bC1Hl4nczq0_eIh6Q9moQjT4kNHl6DItW8MLRV_
 cvxb1uC4K7i3qdsBCFECaza.WBhsHAVeU0ng9Wmm9ytSjC8RCqYD2C49zHOX1AgpIHdcI.CEvqHS
 sKM.YAOWecZ9qCzHIpIDYy5ti7zRsnPW2r6OL27qFs_pU.NsUeXKstYUiq1uQDGtFv4JQYLOh_Bd
 5qYCuZyK7fMUBYVey.j7J7sPt_Jn6C__QMRDkqTKF8NZqofUXdzv63QgMTABMkVdUNpWHNFGfCl1
 e9wrxJthNOtQQl4D7hDlYCohbE14nlkOg7A1pN69HaADWev1VbySS.Jwi161zrUyoYktQsjciD4V
 933QxDoSTVrG6dxfEwMz0Kzltm32HrNwtSjhKK1K_y8.UJJYVe8Of2LiHCWYX53A8kZ98qL..uQt
 o5JxlI6ASY9m0A5SvS7Ay7YfW5sgl94piPZQZoWofS4JV73ayjmRP7Qx5ldppZaHZEQcJPb3yUhl
 uetZ1t7kVlRB5xYiGwxwEE3G3H0BxwYirj1MEru_QOIlm1FqPf6BG.mZGTL6gAEO96JK9NLm.XgC
 taC7LPq0tt3OoO3vAph63quAlGfSEBeoNpPr5w08bAWg0PbMPRunTtGL4cr06ZqLr_e_rMeSqgSX
 PlgJG2t5ozrO2BMv6WL1bs4FNIN79dNrdrLZvpzn1D1nKw0mblnLL9DLr5caflpcQEAg2mBIww5K
 JpPJRGG_k2au41d0EEyaG.3G87udWkrHhOiShARvzti4_qNGZm7._UrjRvviOpZLFDsVE5QEgkuh
 Fnt4zYHlFWeRjHuBlq758qKgQJLw-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: f6e365a8-e464-4168-b4a0-b1340ad380b9
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Tue, 13 May 2025 16:59:40 +0000
Received: by hermes--production-gq1-74d64bb7d7-cmxx8 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2dfd3e28f93fb691722b31ec1d2e481b;
          Tue, 13 May 2025 16:39:22 +0000 (UTC)
Message-ID: <81106a29-90ce-4439-9b4c-60bb2962fe04@schaufler-ca.com>
Date: Tue, 13 May 2025 09:39:21 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 29/29] lsm: add support for counting lsm_prop support
 among LSMs
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
 Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 Fan Wu <wufan@kernel.org>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
 <20250409185019.238841-60-paul@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250409185019.238841-60-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23772 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 4/9/2025 11:50 AM, Paul Moore wrote:
> Add two new variables, lsm_count_prop_subj and lsm_count_prop_obj, to
> count the number of lsm_prop entries for subjects and objects across all
> of the enabled LSMs.  Future patches will use this to continue the
> conversion towards the lsm_prop struct.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  include/linux/lsm_hooks.h         | 6 ++++++
>  security/apparmor/lsm.c           | 1 +
>  security/bpf/hooks.c              | 1 +
>  security/commoncap.c              | 1 +
>  security/integrity/evm/evm_main.c | 1 +
>  security/integrity/ima/ima_main.c | 1 +
>  security/ipe/ipe.c                | 1 +
>  security/landlock/setup.c         | 1 +
>  security/loadpin/loadpin.c        | 1 +
>  security/lockdown/lockdown.c      | 1 +
>  security/lsm.h                    | 4 ++++
>  security/lsm_init.c               | 6 ++++++
>  security/safesetid/lsm.c          | 1 +
>  security/security.c               | 3 +++
>  security/selinux/hooks.c          | 1 +
>  security/smack/smack_lsm.c        | 1 +
>  security/tomoyo/tomoyo.c          | 1 +
>  security/yama/yama_lsm.c          | 1 +
>  18 files changed, 33 insertions(+)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 0d2c2a017ffc..5bc144c5f685 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -71,16 +71,22 @@ struct lsm_static_calls_table {
>  	#undef LSM_HOOK
>  } __packed __randomize_layout;
>  
> +#define LSM_ID_FLG_NONE			0x00000000
> +#define LSM_ID_FLG_PROP_SUBJ		0x00000001
> +#define LSM_ID_FLG_PROP_OBJ		0x00000002
> +
>  /**
>   * struct lsm_id - Identify a Linux Security Module.
>   * @lsm: name of the LSM, must be approved by the LSM maintainers
>   * @id: LSM ID number from uapi/linux/lsm.h
> + * @flags: LSM flags, see LSM_ID_FLG_XXX
>   *
>   * Contains the information that identifies the LSM.
>   */
>  struct lsm_id {
>  	const char *name;
>  	u64 id;
> +	u32 flags;
>  };
>  
>  /*
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 2fefaab6349f..db8592bed189 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1428,6 +1428,7 @@ struct lsm_blob_sizes apparmor_blob_sizes __ro_after_init = {
>  static const struct lsm_id apparmor_lsmid = {
>  	.name = "apparmor",
>  	.id = LSM_ID_APPARMOR,
> +	.flags = LSM_ID_FLG_PROP_SUBJ,
>  };
>  
>  static struct security_hook_list apparmor_hooks[] __ro_after_init = {
> diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
> index 40efde233f3a..c72df6ff69f7 100644
> --- a/security/bpf/hooks.c
> +++ b/security/bpf/hooks.c
> @@ -18,6 +18,7 @@ static struct security_hook_list bpf_lsm_hooks[] __ro_after_init = {
>  static const struct lsm_id bpf_lsmid = {
>  	.name = "bpf",
>  	.id = LSM_ID_BPF,
> +	.flags = LSM_ID_FLG_PROP_SUBJ | LSM_ID_FLG_PROP_OBJ,

There's a problem here. BPF can have properties, but usually does not.
Unless there's a bpf program loaded that provides them it is incorrect
to use these flags. You can't know that at initialization.

I have an alternative that will address this that I will propose
shortly.


