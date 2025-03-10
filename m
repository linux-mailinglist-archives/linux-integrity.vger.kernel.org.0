Return-Path: <linux-integrity+bounces-5200-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C1AA592C1
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Mar 2025 12:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEC167A4B39
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Mar 2025 11:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FC4215F49;
	Mon, 10 Mar 2025 11:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="W/004ubo"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C6E2B9A7;
	Mon, 10 Mar 2025 11:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741606238; cv=none; b=R2ZUK63M1TcUJatDpw65usIHoe8TQAC2BpfvM/xcM/K4eA09tInSLvv9/A6lblELsjAmgb//BiiVWX083DhZDwz/PyqZ+NH5v0RpnbUpAtZXDR0KVt3Hk5EvYCZc+sDd4fbSrEJxG2EHpF9bFva1ruGj95zSgidvNqgeNegz8t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741606238; c=relaxed/simple;
	bh=GRTitHxgBMnFRI7UPKJaKRl2FGqjFtkgd4wwODVouI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8XVtkO6hYcR0x1DpxprpyhpeIJAtiKyoAUvkbpcxr4+59pdxxo561BKWhEX7kSRXHuE772WNkUo22T6JqNZhW4Usv+IzgVRHScJ80YrkJ/3/v7rQJ3U9O6tVc3jG2Jq5BWvohz3c0yObqVMw3fdTzJ+rzidoQYdbWcTcbKLPSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=W/004ubo; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7D7D640E0202;
	Mon, 10 Mar 2025 11:30:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id A55peK9z12U5; Mon, 10 Mar 2025 11:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741606230; bh=FQ40DY5DBRyjcJp7Mre2YFktay6WLnANIARN9EWbnug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W/004uboNjkm19t99ojDVZ49EecyWv3EQCnz4LR+6cqThDSwGQAZEDMtXWiNe4cqS
	 S+d9iTLdq98s3oKPSQT+F4Te+P7PUZW50U9lc0de3O2YzS9tV8HKoxz1VaNwUz1zQy
	 pvl4ShXzKOhDMzVji1zQ3Z/hJyUxG4tkq4tJC7S8cECcp8k2nxfmpqUSYFU+36I79+
	 cVHcBtlBNdcsMvhx0FWIcC5Tw/1KVMK1dd0wuwlBGF3Gxr87p/kME6HSVW4j2P5/5g
	 5siMNOT46EAUzNeeuGWgHNkaK5gFg76nnrz6P+8TxPpjBFXy8CKoKuBAvq//ef7m6E
	 To2YyKgC606x5ss/14N/1Aw8pF/xB68cAQ9GTJE+dbuQdW+6HZbj1YMGnzQFuyTg7O
	 KFfJAKLGLQkXUxvoSZ+u9x51ukc8c3QkHAdEj296Y1ozVQP8ajfj1T4bOLp1p9dmLw
	 DwAtxopd5VILVdscF/VJPl5VbCQ8Kmjui1zd7jqW0fGI6du+JIOYTgcGVFngg9ndOx
	 SAxAC3/4LNk3mLzXjKtWjuTQc8PiSXwT/uC5yQtyf6FfF4b3oXEKQ+bw67jA0Mvngj
	 JegU6z0wPw0tPgeA/aeLp3swlc0NsS/AkSC/q2ap+VyVcLDDCur2P4mc/QB8/YDlYA
	 emDk93Vc1EDY8wn4aOGce4aw=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 89D7240E01AD;
	Mon, 10 Mar 2025 11:30:12 +0000 (UTC)
Date: Mon, 10 Mar 2025 12:30:06 +0100
From: Borislav Petkov <bp@alien8.de>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>, x86@kernel.org,
	Dov Murik <dovmurik@linux.ibm.com>, linux-coco@lists.linux.dev,
	Dionna Glaze <dionnaglaze@google.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH v2 2/6] x86/sev: add SVSM vTPM probe/send_command
 functions
Message-ID: <20250310113006.GFZ87NPu-LgFVVtsEG@fat_crate.local>
References: <20250228170720.144739-1-sgarzare@redhat.com>
 <20250228170720.144739-3-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250228170720.144739-3-sgarzare@redhat.com>

On Fri, Feb 28, 2025 at 06:07:16PM +0100, Stefano Garzarella wrote:
> +bool snp_svsm_vtpm_probe(void)
> +{
> +	struct svsm_call call = {};
> +	u64 send_cmd_mask = 0;
> +	u64 platform_cmds;
> +	u64 features;
> +	int ret;
> +
> +	/* The vTPM device is available only if we have a SVSM */

s/if we have a SVSM/if an SVSM is present/

> +	if (!snp_vmpl)
> +		return false;
> +
> +	call.caa = svsm_get_caa();
> +	call.rax = SVSM_VTPM_CALL(SVSM_VTPM_QUERY);
> +
> +	ret = svsm_perform_call_protocol(&call);
> +


^ Superfluous newline.

> +	if (ret != SVSM_SUCCESS)
> +		return false;
> +
> +	features = call.rdx_out;
> +	platform_cmds = call.rcx_out;
> +
> +	/* No feature supported, it should be zero */
> +	if (features)
> +		pr_warn("SNP SVSM vTPM unsupported features: 0x%llx\n",
> +			features);

So

	return false;

here?

> +
> +	/* TPM_SEND_COMMAND - platform command 8 */
> +	send_cmd_mask = 1 << 8;

	BIT_ULL(8);

> +
> +	return (platform_cmds & send_cmd_mask) == send_cmd_mask;
> +}
> +EXPORT_SYMBOL_GPL(snp_svsm_vtpm_probe);
> +
> +int snp_svsm_vtpm_send_command(u8 *buffer)
> +{
> +	struct svsm_call call = {};
> +
> +	call.caa = svsm_get_caa();
> +	call.rax = SVSM_VTPM_CALL(SVSM_VTPM_CMD);
> +	call.rcx = __pa(buffer);
> +
> +	return svsm_perform_call_protocol(&call);
> +}

In any case, you can zap all those local vars, use comments instead and slim
down the function, diff ontop:

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 3902af4b1385..6d7e97c1f567 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2631,12 +2631,9 @@ static int snp_issue_guest_request(struct snp_guest_req *req, struct snp_req_dat
 bool snp_svsm_vtpm_probe(void)
 {
 	struct svsm_call call = {};
-	u64 send_cmd_mask = 0;
-	u64 platform_cmds;
-	u64 features;
 	int ret;
 
-	/* The vTPM device is available only if we have a SVSM */
+	/* The vTPM device is available only if a SVSM is present */
 	if (!snp_vmpl)
 		return false;
 
@@ -2644,22 +2641,17 @@ bool snp_svsm_vtpm_probe(void)
 	call.rax = SVSM_VTPM_CALL(SVSM_VTPM_QUERY);
 
 	ret = svsm_perform_call_protocol(&call);
-
 	if (ret != SVSM_SUCCESS)
 		return false;
 
-	features = call.rdx_out;
-	platform_cmds = call.rcx_out;
-
 	/* No feature supported, it should be zero */
-	if (features)
-		pr_warn("SNP SVSM vTPM unsupported features: 0x%llx\n",
-			features);
-
-	/* TPM_SEND_COMMAND - platform command 8 */
-	send_cmd_mask = 1 << 8;
+	if (call.rdx_out) {
+		pr_warn("SNP SVSM vTPM unsupported features: 0x%llx\n", call.rdx_out);
+		return false;
+	}
 
-	return (platform_cmds & send_cmd_mask) == send_cmd_mask;
+	/* Check platform commands is TPM_SEND_COMMAND - platform command 8 */
+	return (call.rcx_out & BIT_ULL(8)) == BIT_ULL(8);
 }
 EXPORT_SYMBOL_GPL(snp_svsm_vtpm_probe);
 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

