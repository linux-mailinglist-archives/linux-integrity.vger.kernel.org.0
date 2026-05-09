Return-Path: <linux-integrity+bounces-9505-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Zi8iKUpQ/2nn4gAAu9opvQ
	(envelope-from <linux-integrity+bounces-9505-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 09 May 2026 17:18:34 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8FD5003D9
	for <lists+linux-integrity@lfdr.de>; Sat, 09 May 2026 17:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57F36300F1AB
	for <lists+linux-integrity@lfdr.de>; Sat,  9 May 2026 15:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7781B1A9B58;
	Sat,  9 May 2026 15:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ak4zh1Ya"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D0F15B0EC;
	Sat,  9 May 2026 15:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778339909; cv=none; b=o8gaIDBGt1MVcAXZsvpyoKEiUdwEcItPkqOfS7w7rsaDis2yMvbM3PdKccEW6kjgoFrv0SuqkTD3FLHhrx5CFgkklmQ3Kcsm965j2I6bkbxcMHHSdgffpkUq3MTaEvEe+439K9rlDH3jWvLPnhhjyQgNmUe9ZEp4pAlWFTiOT7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778339909; c=relaxed/simple;
	bh=/ACUJvZGGTfgk7qwE+CEQ+Q/6FZhULEY3LJDvaunTIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gY8018dtC5o263xn7D2yyKysc8HdsND7Z+wopoKfnPXI+u0xZtopxyjK1e1/i9yPR+Xv2qJZu5apQwfnTiDfXc/yoRM0psqN0nF7PyBK2P/wznyaliCRlaSkrEtaNhMEQMd2oiqKgvV3Br0EQnaqlquq6vXB8ACmzynbLljMoTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ak4zh1Ya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90BD6C2BCB2;
	Sat,  9 May 2026 15:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778339908;
	bh=/ACUJvZGGTfgk7qwE+CEQ+Q/6FZhULEY3LJDvaunTIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ak4zh1YayxVoIa7LXt8iqHF5BoUHQisuRChzVwMaiNo750MwM4+MdtjKC58dGPpfj
	 BM+SXNBsRIbdtlMRj/b9xSpkhIIYTaT2XAWyY5tmD+P60x86PkKLPCUde2AVghaYji
	 vffaYs1tLvqjPhTvoVMrtmwiJLY2vNKLWD8i/CVHp0sF+IxgwpbkjfFS7AlLzVRmbq
	 c0AYDKFVA0/8Rd6bCSRmjK02fkUi1y8APdtOrxSXIRQ+ydOauosFvg1R4044fFzSht
	 rf/nlbGGILgZevQ4WWI3/his1uW6ky7job4ba4A6Dbtk+cS36NEFWR1J/BjRx0Z6+p
	 4rb67D4aAkLjQ==
Date: Sat, 9 May 2026 18:18:25 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: "Niedermayr, BENEDIKT" <benedikt.niedermayr@siemens.com>
Cc: "Kiszka, Jan" <jan.kiszka@siemens.com>, Peter Huewe <peterhuewe@gmx.de>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"Bauer, Sven" <svenbauer@siemens.com>,
	"Zeschg, Thomas" <thomas.zeschg@siemens.com>,
	"Gylstorff, Quirin" <quirin.gylstorff@siemens.com>
Subject: Re: [PATCH] hwrng: tpm: Do not enable by default
Message-ID: <af9QQah4QN5VD-4P@kernel.org>
References: <bbc41534-a2d9-42dc-ac8a-ff8a0b4fd41f@siemens.com>
 <aP_NN3HwO4Hp0-9T@kernel.org>
 <96df7b4d-cf1b-471d-9b4b-8741a80fbcc3@siemens.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96df7b4d-cf1b-471d-9b4b-8741a80fbcc3@siemens.com>
X-Rspamd-Queue-Id: 0A8FD5003D9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[siemens.com,gmx.de,vger.kernel.org,linaro.org,lists.trustedfirmware.org];
	TAGGED_FROM(0.00)[bounces-9505-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	HAS_WP_URI(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[siemens.com:email,trustedcomputinggroup.org:url]
X-Rspamd-Action: no action

On Wed, Apr 29, 2026 at 02:33:20PM +0000, Niedermayr, BENEDIKT wrote:
> On 10/27/25 20:51, Jarkko Sakkinen wrote:
> > On Tue, Oct 21, 2025 at 02:46:15PM +0200, Jan Kiszka wrote:
> >> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>
> >> As seen with optee_ftpm, which uses ms-tpm-20-ref [1], a TPM may write
> >> the current time epoch to its NV storage every 4 seconds if there are
> >> commands sent to it. The 60 seconds periodic update of the entropy pool
> >> that the hwrng kthread does triggers this, causing about 4 writes per
> >> requests. Makes 2 millions per year for a 24/7 device, and that is a lot
> >> for its backing NV storage.
> >>
> >> It is therefore better to make the user intentionally enable this,
> >> providing a chance to read the warning.
> >>
> >> [1] https://github.com/Microsoft/ms-tpm-20-ref
> >>
> >> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > 
> > Looking at DRBG_* from [1] I don't see anything you describe. If OPTEE
> > writes NVRAM,  then the implementation is broken.
> > 
> > Also AFAIK, it is pre-seeded per power cycle. There's nothing that even
> > distantly relates on using NVRAM.
> > 
> > [1] https://trustedcomputinggroup.org/wp-content/uploads/TPM-2.0-1.83-Part-4-Supporting-Routines-Code.pdf
> 
> Hi all,
> 
> we recently also stumbled over this issue which led me here to this 
> thread and maybe adding our observations helps to clarify things here a 
> bit (hopefully) or at least augments the information related to firmware 
> TPM based implementation based on ms-tpm-20-ref.
> 
> Based on the optee_ftpm repo, as Jan already described, which currently 
> references commit 98b60a44aba7 of [1] suffers this exact issue because 
> of the NV_CLOCK_UPDATE_INTERVAL [2] which is set to "12" and issues a 
> write for each command after ~4 seconds have passed.
> 
> This config has been changed to "22" (on current master branch [3]) 
> which is the allowed maximum when following the TPM spec (chapter 36.3.2 
> in [4]) which leads to round about 70 minutes, but optee_ftpm didn't 
> move ahead to this commit, yet.
> This config exists for being able to adapt the write cycles to the 
> specific wear conditions of the hardware.
> 
> Moreover the ms-tpm-20-ref repo seems to not be maintained anymore and 
> one should rather switch to [6].
> 
> So there are currently firmware TPM implementations out there that lead 
> to these frequent writes.

Really this would need a product and official bug bulletin for it to
even consider a workaround. Speculation does not count.

> 
> AFAIK since the tpm-20-ref implementation basically only supports a file 
> on disk or RAM backing storage, the optee_ftpm repo [5] provides it's 
> own _plat_NV* implementations that replace the default ones and finally 
> call OP-TEE's TEE_* secure storage API, which then routes to whatever 
> backend OP-TEE is configured with (REE-FS or RPMB) – In our case the RPMB.
> 
> Because there are currently implementations out there (e.g. start using 
> optee_ftpm) it may make sense to add this information to the kernel 
> config's help text at least?

Your first forum to report such issues is the TPM vendor.

> 
> We are currently trying to bump optee_ftpm to use the more recent v1.84, 
> but since we're no TCG member the PRs on github could get a bit 
> adventurous (PR's not upstream, yet).
> Until then this is a valid issue that exists...
> 
> 
> [2] 
> https://github.com/microsoft/ms-tpm-20-ref/blob/98b60a44aba79b15fcce1c0d1e46cf5918400f6a/TPMCmd/tpm/include/TpmProfile.h#L199 
> 
> 
> [3] 
> https://github.com/microsoft/ms-tpm-20-ref/blob/98b60a44aba79b15fcce1c0d1e46cf5918400f6a/TPMCmd/tpm/include/TpmProfile.h#L200
> 
> [4] 
> https://trustedcomputinggroup.org/wp-content/uploads/TPM-2.0-1.83-Part-1-Architecture.pdf
> 
> [5] https://github.com/OP-TEE/optee_ftpm
> 
> [6] https://github.com/TrustedComputingGroup/TPM
> 
> BR,
> Benedikt
> 

BR, Jarkko

