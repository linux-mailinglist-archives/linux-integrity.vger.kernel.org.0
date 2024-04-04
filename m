Return-Path: <linux-integrity+bounces-2001-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1445C897DAB
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Apr 2024 04:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BECD2855C5
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Apr 2024 02:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1987819478;
	Thu,  4 Apr 2024 02:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="M64bDONP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CgKakMnN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F7319470
	for <linux-integrity@vger.kernel.org>; Thu,  4 Apr 2024 02:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712197195; cv=none; b=evdAaQzPceMVYiVmhrpVJHrU51EBdHDnvRVOlI68EOmyelRmyQ/ACjSSvm19To+B/qc/33lbt/mMtskF8Jq4PoX/x39kWdLj/b6GsqP6uv7lWaLunRBpmx2LWk3eqYvyWGajRLTifFGfJUbSrew7a9CtoXuSwkdHnKsw+nnVDZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712197195; c=relaxed/simple;
	bh=MSzPaMzo2/GQFqXfbBNbu0z+jXOwpLqQS0qLqngQggk=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=DntUbyeJLVyyswd6Nx4Xnn4PQcCy1kZdVwIv+yp1Ab+NQFVuDH6uCi2oVx6mifulQrgTGj6+uQYRnpI2IF7J7kAyUzyoXeTE0BVCfIkda5RppnFJBt3rMy1HT+FyG6MaRRqIW9EurKw0Nh6TpsMxNcJYgYFCRzPZA+ciKrfxQqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=M64bDONP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CgKakMnN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D649D5D402;
	Thu,  4 Apr 2024 02:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712197189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cGlClew1HiAGmDmfiveMxoILyFIrS2Ui75/zxAGu3+g=;
	b=M64bDONPqZG3eEsABVkyftqzA1mjxlPbH6JvHmZtnXVJ4XnHx6ojd7pZspCkujpMP+zVPY
	vVD67L9lrlBhzTAnXfAI0+d+1YGu6bGC/NeHkP9o22AetWs9bqImGDtCxUr6bxDU4Y0qUA
	iYq+TEjlyqq/CQXXA+1X8o6vumtSOE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712197189;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cGlClew1HiAGmDmfiveMxoILyFIrS2Ui75/zxAGu3+g=;
	b=CgKakMnNvdCj/B9dZp4s0BkIP1nkrTFYJXOO1lmUbQoRdMEX0oeq6zWpZdF+MHD5gKPfG3
	mtX+8QX02mZNntBA==
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id AE685139F4;
	Thu,  4 Apr 2024 02:19:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id HeEtGEMODmY4KAAAn2gu4w
	(envelope-from <wbrown@suse.de>); Thu, 04 Apr 2024 02:19:47 +0000
From: William Brown <wbrown@suse.de>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6.1.1\))
Subject: TPM error 0x0901, possibly related to TPM2_PT_CONTEXT_GAP_MAX
Message-Id: <424B3F10-D91C-4F47-B33C-BB66FE4DB91A@suse.de>
Date: Thu, 4 Apr 2024 12:19:34 +1000
Cc: peterhuewe@gmx.de,
 jarkko@kernel.org,
 jgg@ziepe.ca,
 Takashi Iwai <tiwai@suse.de>
To: linux-integrity@vger.kernel.org
X-Mailer: Apple Mail (2.3731.700.6.1.1)
X-Spam-Score: -3.79
X-Spamd-Result: default: False [-3.79 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 MV_CASE(0.50)[];
	 FREEMAIL_ENVRCPT(0.00)[gmx.de];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.19)[-0.973];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[gmx.de,kernel.org,ziepe.ca,suse.de];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO

Hi all,

I've been recently working on enabling TPM support within a number of =
PAM modules. I'm certainly not a TPM expert, but I have noticed some =
issues when testing.

We have a number of tests/examples in the rust-tss-esapi project, such =
as an example that shows how to hmac a value:

```
# TCTI=3Ddevice:/dev/tpmrm0 cargo run --example hmac --features =
generate-bindings
    Finished dev [unoptimized + debuginfo] target(s) in 0.07s
     Running `target/debug/examples/hmac`
true: TpmProperties(TaggedTpmPropertyList { tagged_tpm_properties: [] })
hmac1 =3D Digest(Zeroizing([54, 176, 122, 39, 222, 112, 105, 131, 3, =
158, 89, 12, 38, 14, 184, 176, 97, 38, 60, 37, 9, 49, 176, 80, 191, 161, =
64, 233, 163, 47, 254, 1]))
hmac2 =3D Digest(Zeroizing([54, 176, 122, 39, 222, 112, 105, 131, 3, =
158, 89, 12, 38, 14, 184, 176, 97, 38, 60, 37, 9, 49, 176, 80, 191, 161, =
64, 233, 163, 47, 254, 1]))
```

When this test program is run repeatedly, it begins to fail with:

ERROR:tcti:src/tss2-tcti/tcti-device.c:197:tcti_device_receive() Failed =
to get response size fd 3, got errno 14: Bad address
=
ERROR:esys:src/tss2-esys/api/Esys_FlushContext.c:238:Esys_FlushContext_Fin=
ish() Received a non-TPM Error
ERROR:esys:src/tss2-esys/api/Esys_FlushContext.c:89:Esys_FlushContext() =
Esys Finish ErrorCode (0x000a000a)
thread 'main' panicked at tss-esapi/examples/hmac.rs:170:48:
called `Result::unwrap()` on an `Err` value: =
TssError(Tcti(TctiReturnCode { base_error: IoError }))
stack backtrace:

This is associated with dmesg erros such as:

[83754.340909] tpm tpm0: tpm2_save_context: failed with a TPM error =
0x0901
[83754.343680] tpm tpm0: A TPM error (459) occurred flushing context
[83754.345650] tpm tpm0: tpm2_commit_space: error -14


Research indicated the following issue:

https://github.com/tpm2-software/tpm2-tools/issues/2279

Since I am currently using the kernel resource manager, this may be =
related. To investigate further, I reviewed the TSS Resource Manager =
document and noted in section 3.15 a number of properties related to =
sessions. Dumping these I see the following values:

true: TpmProperties(TaggedTpmPropertyList { tagged_tpm_properties: =
[TaggedProperty { property: HrLoaded, value: 0 }] })
true: TpmProperties(TaggedTpmPropertyList { tagged_tpm_properties: =
[TaggedProperty { property: HrLoadedAvail, value: 3 }] })
true: TpmProperties(TaggedTpmPropertyList { tagged_tpm_properties: =
[TaggedProperty { property: HrActive, value: 1 }] })
true: TpmProperties(TaggedTpmPropertyList { tagged_tpm_properties: =
[TaggedProperty { property: HrActiveAvail, value: 63 }] })
true: TpmProperties(TaggedTpmPropertyList { tagged_tpm_properties: =
[TaggedProperty { property: ActiveSessionsMax, value: 64 }] })
true: TpmProperties(TaggedTpmPropertyList { tagged_tpm_properties: =
[TaggedProperty { property: ContextGapMax, value: 255 }] })

So we can see that there are sufficient available sessions, but that the =
context gap max is 0xFF per the github issue.

Checking with tpm2_getcap I see:

TPM2TOOLS_TCTI=3Ddevice:/dev/tpmrm0 tpm2_getcap properties-fixed
TPM2_PT_CONTEXT_GAP_MAX:
  raw: 0xFF

TPM2TOOLS_TCTI=3Ddevice:/dev/tpm0 tpm2_getcap properties-fixed
TPM2_PT_CONTEXT_GAP_MAX:
  raw: 0xFFFFFFFF

My assumption would be that the same issue as the github issue notes =
persists today, but Im certainly not an expert on the interactions that =
are occuring. My first assumption was that my own programs were =
exhausting the resources of the TPM, but after tracking the session =
totals and properties, I'm not sure it's something my examples are doing =
wrong.

However, if you wait for a few minutes, the TPM appears to "unjam" and =
starts to respond again.

These tests were performed on an openSUSE Tumbleweed virtual machine =
with a libvirt TPM provided by swtpm.=20

Any ideas what could be going on?=20

--
Sincerely,

William Brown

Senior Software Engineer,
Identity and Access Management
SUSE Labs, Australia


