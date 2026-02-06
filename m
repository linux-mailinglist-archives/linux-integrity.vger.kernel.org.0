Return-Path: <linux-integrity+bounces-8474-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DVWIcxEhmn5LQQAu9opvQ
	(envelope-from <linux-integrity+bounces-8474-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 06 Feb 2026 20:45:16 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2AD102E30
	for <lists+linux-integrity@lfdr.de>; Fri, 06 Feb 2026 20:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 60F00300DCDB
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Feb 2026 19:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1629A30E0D9;
	Fri,  6 Feb 2026 19:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="d+yR6eE8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E50C335079
	for <linux-integrity@vger.kernel.org>; Fri,  6 Feb 2026 19:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770407113; cv=none; b=rp2nK6MnrlSA9rIppZAJY4BlKgvNGnBbKPcgdhZJKI1R5ZNjLI7lJH3dyv9U0jedZgxPWh+YkVrQeGlPbb5y5AeKj2IJQtxwP/BlPZjuJ76V+gBQnzO2gosRxkCyIQmVeThpeKtWW+DTcJ7LLG8NGMtmquHoce987lUG1B9iC2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770407113; c=relaxed/simple;
	bh=iOQJDJ2wi5Q0xI88Xk+AswOr7WepFuB/4ql8iPeeIck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qaMmpC706be6GGCbq2KxsyXTwZFEHBsGw5Ij6FwDuM8lFd/++uuiDSjshA4qyeDwRsA4ud+mXop9IDLbIdMlRG3tCVaLMcjJgQGc8l1IzN/dhnKP6lZ44vQGZdtaqrE95gWfQUBCiZ7s/z8W0Bn805GXTSj74Ye2imDWROVeAUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=d+yR6eE8; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=NgSebhCxpmLqJ7zEr/xAa1mDZLTBdOeakCAt5gVFewU=; b=d+yR6eE88t023KpWaRA+TIsNFQ
	XvvXljBtWB/zknknUKGgnLFK+YRx0a176ZlnEagjdgFTjlQJVjfPPoIdOzJB1J2yR56361y0Iz9Bp
	PmHXreWabPZSybL3BfqdmuqnTyjeCK/QoNzYTKKEfN3MYvgERh5Hu9m099xcsolRehay+pJNgoQbx
	XfgVMfdaWRj+mfcNwhNXMQCoKfUcnqF7DT5Gt/nSV+B0fY4Z0n4oA/Bc5sLT1r0RQ8zfvS0Njstds
	yZuNcM8bd3iUuXr4CAlkucftlCxUkOFj+WIPCYR3Roirw+cEZ8B5hd/bmF3yfWltQ6Ycvx1+v1pbg
	TmAgSR7A==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1voRlO-00DGrQ-0g;
	Fri, 06 Feb 2026 19:45:10 +0000
Date: Fri, 6 Feb 2026 19:45:10 +0000
From: Jonathan McDowell <noodles@earth.li>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, Romain Naour <romain.naour@smile.fr>
Subject: Re: IMA vs TPM (SPI) boot order problems
Message-ID: <aYZExjwPPLOLoWGk@earth.li>
References: <aYXEepLhUouN5f99@earth.li>
 <f8b3451a6ef619dd2934bc839618fabc9408967c.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <f8b3451a6ef619dd2934bc839618fabc9408967c.camel@linux.ibm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[earth.li:s=the];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8474-lists,linux-integrity=lfdr.de];
	DMARC_NA(0.00)[earth.li];
	DKIM_TRACE(0.00)[earth.li:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[noodles@earth.li,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6F2AD102E30
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 10:36:36AM -0500, Mimi Zohar wrote:
>On Fri, 2026-02-06 at 10:37 +0000, Jonathan McDowell wrote:
>> I'm seeing an issue with a SPI attached TPM, where it's not coming up
>> early enough for IMA to decide there's a TPM available that it can
>> measure into. The TPM is definitely present, and by the time we get to
>> userspace it's working fine.
>>
>> This is sort of resurrecting a post from 2024 by Romain, though that
>> concerned an i2c TPM:
>>
>> https://lore.kernel.org/all/9b98d912-ba78-402c-a5c8-154bef8794f7@smile.fr/
>>
>> There doesn't seem to have actually been a fixed applied, so I tried the
>> late_initcall_sync suggestion, but that didn't change things:
>>
>> [    0.000000] ACPI: TPM2 0x0000004044BCA998 00004C (v04 ALASKA A M I    00000001 AMI  00000000)
>> [    0.000000] GICv3: 960 SPIs implemented
>> [    0.000000] GICv3: 320 Extended SPIs implemented
>> [    0.000447] LSM: initializing lsm=capability,bpf,ima
>> [    0.394832] Trying to unpack rootfs image as initramfs...
>> [    0.681134] tegra-qspi NVDA1513:00: Adding to iommu group 1
>> [    0.681241] tegra-qspi NVDA1513:00: device reset failed
>> [    0.686925] tpm_tis_spi spi-PRP0001:01: 2.0 TPM (device-id 0x1B, rev-id 22)
>> [    0.894451] ima: No TPM chip found, activating TPM-bypass!
>> [    0.894462] ima: Allocated hash algorithm: sha256
>> [    0.894471] ima: No architecture policies found
>>
>> This seems to show SPI + the TPM coming up before IMA, but still not in
>> a way that makes IMA happy.
>
>Here's an example with really well written patch descriptions, that was
>upstreamed:
>
>746d9e9f62a6 ("tpm: tpm_crb_ffa: try to probe tpm_crb_ffa when it's built-in")
>0e0546eabcd6 ("firmware: arm_ffa: Change initcall level of ffa_init() to
>rootfs_initcall")

Thanks Mimi, really useful pointers. I think the TPM/SPI chain is a 
little bit more tricky (I guess I can just fix the path that works for 
me, rather than *any* SPI bus driver), but I'll investigate.


J.

-- 
Shall I call the United Nations?
This .sig brought to you by the letter W and the number 30
Product of the Republic of HuggieTag

