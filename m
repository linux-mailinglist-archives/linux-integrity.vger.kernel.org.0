Return-Path: <linux-integrity+bounces-9574-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4G/OCfiXB2r/9wIAu9opvQ
	(envelope-from <linux-integrity+bounces-9574-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 16 May 2026 00:02:32 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A54EE5588C0
	for <lists+linux-integrity@lfdr.de>; Sat, 16 May 2026 00:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0EA3C300989F
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 22:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3003E9F71;
	Fri, 15 May 2026 22:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cHvfDJ7E"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2184405C4C;
	Fri, 15 May 2026 22:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778882549; cv=none; b=e0574ey6M7x/joJUmP5u9BFEuQZES1SHKCQLTPZph2zvHO4SMz+R7t0n053GPc7NbVSr/AB4LV0fXoai7PXDfTjJLfYBaKKqNrps8L3q1vJneYQekZ9d6/xZfNMbJq9vjd8KanTJ/csYzF0vc/Aeh9cqxx4eHa5zByZQ4iHqCRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778882549; c=relaxed/simple;
	bh=9shdINYCeu/iCM4bhRdVfwFzaqlkrXm1jjxi4asaJNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JDVJbo8mKwbvHOFosPRAv32iD4y3Czj4RRHj+Duqe7tQotDJMl7mSTovjbmxcQ46qTTBfIJ7PSq+gt3pA962JK3qOf9R/v60Ek1O0S9okixxW1Q9/qsEKTNB1HbTcU+OUL+Zp+gi3sCudXyIva9Y0oUsK8PP9cnZtcmFnhTQw9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cHvfDJ7E; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=0GGVXnEvwyvUGTIvy68sh7LB/BlAa3dzEnbAfye67mM=; b=cHvfDJ7E6qzMMKhGfRDHuDYPRd
	DNBcxSlblWFVG4meivRiU7ZII/xT8S3xdDUnwsStSTUsMFeP1s7dXFBz4PV/DTBEaRywErY3RO7sJ
	z+JaS96pC2S48Aa0fdnfESTeUWw6usyq3G2wSvmyWQTA8IUMKiaQwfbxtvz2dTYsQtP1qdXLKa2BN
	YlwuGckZaltz0KZrPoNezs6I4xOreJASX5YcnZgR8CnYC7WxSo5JTMKlXCtWLDRyldbJ4u5Lf6oM5
	lqD5QeKdfPp47etbSY6tatu5mYddIBsHEvC/wyyH4m4jEAG0gAsQ3yzwpnCQ5OU4E2mlDO31m7qMP
	ZYBasHrA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wO0bp-00000009af0-2lX8;
	Fri, 15 May 2026 22:02:17 +0000
Message-ID: <130c4cfa-7388-462f-9b0f-7939680a90ed@infradead.org>
Date: Fri, 15 May 2026 15:02:16 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 15/38] Documentation/security: Secure Launch kernel
 documentation
To: Ross Philipson <ross.philipson@gmail.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux.dev
Cc: dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org,
 mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
 nivedita@alum.mit.edu, herbert@gondor.apana.org.au, davem@davemloft.net,
 corbet@lwn.net, ebiederm@xmission.com, dwmw2@infradead.org,
 baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
 daniel.kiper@oracle.com, andrew.cooper3@citrix.com,
 trenchboot-devel@googlegroups.com
References: <20260515211410.31440-1-ross.philipson@gmail.com>
 <20260515211410.31440-16-ross.philipson@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260515211410.31440-16-ross.philipson@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A54EE5588C0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9574-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kernel.org,lists.infradead.org,lists.linux.dev];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[apertussolutions.com,linutronix.de,redhat.com,alien8.de,zytor.com,linux.intel.com,kernel.org,srcf.ucam.org,hansenpartnership.com,gmx.de,ziepe.ca,amacapital.net,alum.mit.edu,gondor.apana.org.au,davemloft.net,lwn.net,xmission.com,infradead.org,oracle.com,citrix.com,googlegroups.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	HAS_WP_URI(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:url,infradead.org:mid,infradead.org:dkim,apertussolutions.com:email,trenchboot.org:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action



On 5/15/26 2:13 PM, Ross Philipson wrote:
> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
> 
> Introduce documentation for the Linux Secure Launch feature.
> 
> Co-developed-by: Ross Philipson <ross.philipson@gmail.com>
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
> ---
>  Documentation/arch/x86/boot.rst               |   8 +
>  Documentation/security/index.rst              |   1 +
>  .../security/launch-integrity/index.rst       |   9 +
>  .../launch-integrity/secure_launch.rst        | 681 ++++++++++++++++++
>  4 files changed, 699 insertions(+)
>  create mode 100644 Documentation/security/launch-integrity/index.rst
>  create mode 100644 Documentation/security/launch-integrity/secure_launch.rst
> 


> diff --git a/Documentation/security/launch-integrity/secure_launch.rst b/Documentation/security/launch-integrity/secure_launch.rst
> new file mode 100644
> index 000000000000..b4c61fdceaf0
> --- /dev/null
> +++ b/Documentation/security/launch-integrity/secure_launch.rst
> @@ -0,0 +1,681 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. Copyright (c) 2019-2026 Daniel P. Smith <dpsmith@apertussolutions.com>
> +
> +======================
> +Secure Launch Overview
> +======================
> +
> +:Author: Daniel P. Smith
> +:Date: February 2026

maybe update?

> +
> +Overview
> +========

[snip]

> +Error Codes
> +===========
> +
> +The TXT specification defines the layout for TXT 32 bit error code values.

                                                    32-bit

> +The bit encodings indicate where the error originated (e.g. with the CPU,
> +in the SINIT ACM, in software). The error is written to a sticky TXT
> +register that persists across resets called TXT.ERRORCODE (see the TXT
> +MLE Development Guide). The errors defined by the Secure Launch feature are
> +those generated in the MLE software. They have the format::
> +
> +  0xc0008XXX
> +
> +The low 12 bits are free for defining the following Secure Launch specific
> +error codes.

[snip]

> +Resources
> +=========
> +
> +The TrenchBoot project:
> +
> +https://trenchboot.org
> +
> +Secure Launch Specification:
> +
> +https://trenchboot.org/specifications/Secure_Launch/
> +
> +Trusted Computing Group's D-RTM Architecture:
> +
> +https://trustedcomputinggroup.org/wp-content/uploads/TCG_D-RTM_Architecture_v1-0_Published_06172013.pdf
> +
> +TXT documentation in the Intel TXT MLE Development Guide:
> +
> +https://www.intel.com/content/dam/www/public/us/en/documents/guides/intel-txt-software-development-guide.pdf
> +
> +TXT instructions documentation in the Intel SDM Instruction Set volume:
> +
> +https://software.intel.com/en-us/articles/intel-sdm
> +
> +AMD SKINIT documentation in the System Programming manual:
> +
> +https://www.amd.com/system/files/TechDocs/24593.pdf
> +
> +GRUB Secure Launch support:
> +
> +https://github.com/TrenchBoot/grub/tree/grub-sl-fc-38-dlstub
> +
> +FOSDEM 2021: Secure Upgrades with DRTM
> +
> +https://archive.fosdem.org/2021/schedule/event/firmware_suwd/
> +
> +.. [1]
> +    MLE: Measured Launch Environment is the binary runtime that is measured and
> +    then run by the TXT SINIT ACM. The TXT MLE Development Guide describes the
> +    requirements for the MLE in detail.
> +
> +.. [2]
> +    PMR: Intel VTd has a feature in the IOMMU called Protected Memory Registers.
> +    There are two of these registers and they allow all DMA to be blocked
> +    to large areas of memory. The low PMR can cover all memory below 4Gb on 2Mb
> +    boundaries. The high PMR can cover all RAM on the system, again on 2Mb
> +    boundaries. This feature is used during a Secure Launch by TXT.
> +
> +.. [3]
> +    Secure Launch Specification: https://trenchboot.org/specifications/Secure_Launch/
> +
> +.. [4]
> +    ACM: Intel's Authenticated Code Module. This is the 32b bit binary blob that

Does "32b" mean something or should that be 32-bit?

> +    is run securely by the GETSEC[SENTER] during a measured launch. It is described
> +    in the Intel documentation on TXT and versions for various chipsets are
> +    signed and distributed by Intel.

-- 
~Randy


