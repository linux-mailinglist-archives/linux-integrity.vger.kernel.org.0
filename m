Return-Path: <linux-integrity+bounces-8673-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEBaCxFNoWkfsAQAu9opvQ
	(envelope-from <linux-integrity+bounces-8673-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Feb 2026 08:51:45 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A666D1B41BB
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Feb 2026 08:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86B803032054
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Feb 2026 07:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B06355F35;
	Fri, 27 Feb 2026 07:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnJR1Ri0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CEC3290CA;
	Fri, 27 Feb 2026 07:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772178682; cv=none; b=c1Pjt0xXwBnT0cxFH2fXSdGwmnkhs4QNh2W9A+eWpNj3f4oHnRr0GIBe9FYs5zlOW/0PrE5kW4Ih7TirIg+OM9Ccz77QwsnMWXksqG/ck/K7IvxsleQM0uHabunMA5k9SdZ11Cd0KmR6nrBlrTT5QhGa3qVHv4FmKhwOI5QVa8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772178682; c=relaxed/simple;
	bh=FuwJ4dFEMoOWUXSsbBn5R1/MzLKf04Ey3jVnqdyvQaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e7yylkQ2GiR1jEkq+bViMTGK21XFPpUUeci58F7IUa72C76AlVdkc1LJl7MUQGU0hR4I6yryjnkBJ5NXlSZxEgrL4pytD1Mje9GuJGKycHAJndFCyOnn2Un/BDlVq61yqfe5tgrVogfa2wC0tMVXZ/85MS/GUT+iDlP8vJ8v57w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnJR1Ri0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0F4C116C6;
	Fri, 27 Feb 2026 07:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772178681;
	bh=FuwJ4dFEMoOWUXSsbBn5R1/MzLKf04Ey3jVnqdyvQaA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mnJR1Ri0HlkV4Dai35gEyErjrdRIBpO4AcgWYMZ32L/4AGLK5MBEWxqmkTaZ318N5
	 pB7otq2jdQRQV1+qztqAs9fehuvEo9GgL0FoEw2Cht9wEXi2gUbi/U54aeB3C9nMad
	 5az7xMleO+ONHOEwNTW90zNb9vJ5fkCtOleepZjN96Irept03ErO8dGTgSAdNbDrc+
	 QSUyNhDg4W7+2/GL4RJ9jdI9N5xbD3YM7wKB9d4r26aDN1fyzsjE1eV1tEcQyHPIs3
	 mNOilMCYGlXI3qJ6g4zThYMdKBtv1LA7MZauVX1rewLA+k2y8mhK/0LXxGpxfmxuWw
	 juPlTGhSjEPCg==
Message-ID: <31dfcf7a-5b3d-406d-bdd4-c8b09f7eb1f0@kernel.org>
Date: Fri, 27 Feb 2026 08:51:15 +0100
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/6] Extend "trusted" keys to support a new trust
 source named the PowerVM Key Wrapping Module (PKWM)
To: Srish Srinivasan <ssrish@linux.ibm.com>, linux-integrity@vger.kernel.org,
 keyrings@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
 zohar@linux.ibm.com, nayna@linux.ibm.com, rnsastry@linux.ibm.com,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20260201135930.898721-1-ssrish@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260201135930.898721-1-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8673-lists,linux-integrity=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,ellerman.id.au,gmail.com,HansenPartnership.com,kernel.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chleroy@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: A666D1B41BB
X-Rspamd-Action: no action



Le 01/02/2026 à 14:59, Srish Srinivasan a écrit :
> Power11 has introduced a feature called the PowerVM Key Wrapping Module
> (PKWM), where PowerVM in combination with Power LPAR Platform KeyStore
> (PLPKS) [1] supports a new feature called "Key Wrapping" [2] to protect
> user secrets by wrapping them using a hypervisor generated wrapping key.
> This wrapping key is an AES-GCM-256 symmetric key that is stored as an
> object in the PLPKS. It has policy based protections that prevents it from
> being read out or exposed to the user. This wrapping key can then be used
> by the OS to wrap or unwrap secrets via hypervisor calls.
> 
> This patchset intends to add the PKWM, which is a combination of IBM
> PowerVM and PLPKS, as a new trust source for trusted keys. The wrapping key
> does not exist by default and its generation is requested by the kernel at
> the time of PKWM initialization. This key is then persisted by the PKWM and
> is used for wrapping any kernel provided key, and is never exposed to the
> user. The kernel is aware of only the label to this wrapping key.
> 
> Along with the PKWM implementation, this patchset includes two preparatory
> patches: one fixing the kernel-doc inconsistencies in the PLPKS code and
> another reorganizing PLPKS config variables in the sysfs.
> 
> Changelog:
> 
> v6:

Seems like v5 was applied, if needed can you send followup patch ?

Christophe

> 
> * Patch 1 to Patch 3:
>    - Add Nayna's Tested-by tag
> * Patch 4
>    - Fix build error reported by kernel test robot <lkp@intel.com>
>    - Add Nayna's Tested-by tag
> * Patch 5
>    - Add Nayna's Tested-by tag
> 
> v5:
> 
> * Patch 1 to Patch 3:
>    - Add Nayna's Reviewed-by tag
> * Patch 4:
>    - Fix build error identified by chleroy@kernel.org
>    - Add Nayna's Reviewed-by tag
> * Patch 5:
>    - Add Reviewed-by tags from Nayna and Jarkko
> 
> v4:
> 
> * Patch 5:
>    - Add a per-backend private data pointer in trusted_key_options
>      to store a pointer to the backend-specific options structure
>    - Minor clean-up
> 
> v3:
> 
> * Patch 2:
>    - Add Mimi's Reviewed-by tag
> * Patch 4:
>    - Minor tweaks to some print statements
>    - Fix typos
> * Patch 5:
>    - Fix typos
>    - Add Mimi's Reviewed-by tag
> * Patch 6:
>    - Add Mimi's Reviewed-by tag
> 
> v2:
> 
> * Patch 2:
>    - Fix build warning detected by the kernel test bot
> * Patch 5:
>    - Use pr_debug inside dump_options
>    - Replace policyhande with wrap_flags inside dump_options
>    - Provide meaningful error messages with error codes
> 
> Nayna Jain (1):
>    docs: trusted-encryped: add PKWM as a new trust source
> 
> Srish Srinivasan (5):
>    pseries/plpks: fix kernel-doc comment inconsistencies
>    powerpc/pseries: move the PLPKS config inside its own sysfs directory
>    pseries/plpks: expose PowerVM wrapping features via the sysfs
>    pseries/plpks: add HCALLs for PowerVM Key Wrapping Module
>    keys/trusted_keys: establish PKWM as a trusted source
> 
>   .../ABI/testing/sysfs-firmware-plpks          |  58 ++
>   Documentation/ABI/testing/sysfs-secvar        |  65 --
>   .../admin-guide/kernel-parameters.txt         |   1 +
>   Documentation/arch/powerpc/papr_hcalls.rst    |  43 ++
>   .../security/keys/trusted-encrypted.rst       |  50 ++
>   MAINTAINERS                                   |   9 +
>   arch/powerpc/include/asm/hvcall.h             |   4 +-
>   arch/powerpc/include/asm/plpks.h              |  95 +--
>   arch/powerpc/include/asm/secvar.h             |   1 -
>   arch/powerpc/kernel/secvar-sysfs.c            |  21 +-
>   arch/powerpc/platforms/pseries/Makefile       |   2 +-
>   arch/powerpc/platforms/pseries/plpks-secvar.c |  29 -
>   arch/powerpc/platforms/pseries/plpks-sysfs.c  |  96 +++
>   arch/powerpc/platforms/pseries/plpks.c        | 688 +++++++++++++++++-
>   include/keys/trusted-type.h                   |   7 +-
>   include/keys/trusted_pkwm.h                   |  33 +
>   security/keys/trusted-keys/Kconfig            |   8 +
>   security/keys/trusted-keys/Makefile           |   2 +
>   security/keys/trusted-keys/trusted_core.c     |   6 +-
>   security/keys/trusted-keys/trusted_pkwm.c     | 190 +++++
>   20 files changed, 1207 insertions(+), 201 deletions(-)
>   create mode 100644 Documentation/ABI/testing/sysfs-firmware-plpks
>   create mode 100644 arch/powerpc/platforms/pseries/plpks-sysfs.c
>   create mode 100644 include/keys/trusted_pkwm.h
>   create mode 100644 security/keys/trusted-keys/trusted_pkwm.c
> 


