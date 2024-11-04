Return-Path: <linux-integrity+bounces-4006-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B51A69BB2AD
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Nov 2024 12:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7E931C209B0
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Nov 2024 11:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A921B6CFE;
	Mon,  4 Nov 2024 10:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="GIIdlh5w"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sender4-of-o51.zoho.com (sender4-of-o51.zoho.com [136.143.188.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17621B372C;
	Mon,  4 Nov 2024 10:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717852; cv=pass; b=gIFLeMWqaK9dSCVudhMP0U1nJpDlfrm0w+8SRW/noI4Fi8tqj/D2axd0qnRQfUN0SQswD3y/HFv9jfW7AJNijYZyGrEsywoLjUhJKMGnOqF6NGncTjEjMGN3bMH6ubQWyJVpfLgZ2PzB78kfjmcGSskc+vEVLJQ3Rih/B/8iPXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717852; c=relaxed/simple;
	bh=fOpkG52q1A+HtoIJfAJXCeTIHRMQs3xXp9NhZVlXvBU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=r52sT4yMwk8wqkURbsIfZ6yplUTjEbiLJU82gNQ8bQIXcK/J/SokM1+cNTisZ/fsWtxPVfmZBa87K46xWDRKLjMFVDijBdgSMHhVlu3NbYT7UzVrNL8naXqOEqs9BGLQH2GFQqd6JbTbGe6N0sO2N5kLR1cPYp4pBzc92171Z0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com; spf=pass smtp.mailfrom=apertussolutions.com; dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b=GIIdlh5w; arc=pass smtp.client-ip=136.143.188.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1730717831; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WoxPHBCaNZsN1PY8VHPMdaSTmp0IMj5cvLoFQLiAI5qJ4BBGbczBnqxh3Z2mPLEW7+io+aEhtsqwbr/RjjZX1yMlxqfzBqanemwJ/063J/UC0SSPLyRokWC/wfMoY3ysSzUcuOrDWUs2fSpjGLqigr7ky719ANCjs4dizuxGNFU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1730717831; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NCYgbbjvLSlIO5KLUNVwElkEFTf5UhLG5MjWOWtA/BM=; 
	b=dKsvtcyVHJ9/D7wfPZ1iqk3YFjDgvdoUkcxXwulzhP5uLYeARLEY8SmkQbPwceQhVmjeJe2+632e2hLoQfuxoQxwpxYBlf9tr5TH1/hJfiAvnI/2roLChg1qPEmpQMyk8uUxpEs+06b9yKHd/SHHSkBW2Q2gd2c7Abi2qN4p010=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730717831;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:From:From:Subject:Subject:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=NCYgbbjvLSlIO5KLUNVwElkEFTf5UhLG5MjWOWtA/BM=;
	b=GIIdlh5wirXlKagVoJfCMGEKO+314eFkR70UHRm+iBDyI8RLB4WFavmAvSsr3qc9
	RsUKu+zOlxOCn/SQ7HMOSi6fVGtOhF5/9RgqA8AMy6d8rH40onYH5QCHbrCBssANph1
	Gh5TmacJR4b/iaPS2XblexVQX4CZT0Kzrfb6eNsw=
Received: by mx.zohomail.com with SMTPS id 1730717828500465.26295474390076;
	Mon, 4 Nov 2024 02:57:08 -0800 (PST)
Message-ID: <e745226d-4722-43ed-86ad-89428f56fcba@apertussolutions.com>
Date: Mon, 4 Nov 2024 05:57:01 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Subject: Re: [RFC PATCH 0/4] Alternative TPM patches for Trenchboot
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: x86@kernel.org, Ross Philipson <ross.philipson@oracle.com>,
 Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20241102152226.2593598-1-jarkko@kernel.org>
 <D5BW0P0HH0QL.7Y4HBLJGEDL8@kernel.org>
Content-Language: en-US
In-Reply-To: <D5BW0P0HH0QL.7Y4HBLJGEDL8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 11/2/24 14:00, Jarkko Sakkinen wrote:
> On Sat Nov 2, 2024 at 5:22 PM EET, Jarkko Sakkinen wrote:
>> It is not really my problem but I'm also wondering how the
>> initialization order is managed. What if e.g. IMA happens to
>> initialize before slmodule?
> 
> The first obvious observation from Trenchboot implementation is that it
> is 9/10 times worst idea ever to have splitted root of trust. Here it
> is realized by an LKM for slmodule.

First, there is no conflict between IMA and slmodule. With your change 
to make locality switching a one shot, the only issue would be if IMA 
were to run first and issue a locality switch to Locality 0, thus 
blocking slmodule from switching to Locality 2. As for PCR usage, IMA 
uses the SRTM PCRs, which are completely accessible under Locality 2.

The RoT for DRTM is the CPU/microcode, and that is not split. I am going 
to assume that you are speaking about the delay between the time of 
collecting measurement to the time of storing measurement? As a 
refresher, an RTM trust chain is constructed using the transitive 
trust[1] process. As noted in the definition, the Linux kernel in this 
case is considered a group of functions that were all evaluated and 
considered functions to be equally part of the TCB. This means you are 
trusting actions at time interval M equally to an action taken at time 
interval N. If one attempts to construct an argument that claims this is 
invalid, that would mean all RTM trust chains constructed in this manner 
are invalidated, including SRTM aka SecureBoot. This means as long as 
the measurements are recorded before the TCB is extended again, then it 
does not matter if it is done at time M or time N.

Bringing this back to SecureLaunch, there would only be an issue if 
slmodule could be built as an external loadable module, thus not being 
part of the "group of functions" measured and executed by the SINIT ACM. 
AFAICT, slmodule can only either be compiled in or out, not as a 
loadable module. If there is a path we missed that allows it to be built 
as a loadable module, then that needs correcting. Due to this comment, I 
went testing KCONFIG options and could not come up with a way for this 
to occur. I did see that we probably should change CONFIG_SECURE_LAUNCH 
dependency from TCG_TPM to TPM_TIS and TCG_CRB. Just to avoid an invalid 
configuration where the necessary interfaces were not present, leading 
to triggering a TXT reset of the platform.

[1] Transitive trust (TCG D-RTM Architecture - Version 1.0.0)
Also known as "inductive trust." In this process, the Root of Trust 
gives a trustworthy description of a second group of functions. Based on 
this description, an interested entity can determine the trust it is to 
place in this second group of functions. If the interested entity 
determines that the trust level of the second group of functions is 
acceptable, the trust boundary is extended from the Root of Trust to
include the second group of functions. In this case, the process can be
iterated. The second group of functions can give a trustworthy 
description of the third group of functions, etc. Transitive trust is 
used to provide a trustworthy description of platform characteristics.

> So based on that usually a literal and unquestionable truth, when it
> comes to securing platforms, the next question is how to make a single
> atomic root of trust for Trenchboot.
As mentioned above, there is no split currently.

> There is really only one answer I think of for this it to make slmodule
> part of the tpm_tis_core and also init order will be sorted out.

Only if your assertion that it was split, which it is not.

> I'll describe the steps forward.

Honestly, a better path forward would be to revisit the issue that is
driving most of that logic existing, which is the lack of a TPM
interface code in the setup kernel. As a reminder, this issue is due to
the TPM maintainers position that the only TPM code in the kernel can be
the mainline driver. Which, unless something has changed, is impossible
to compile into the setup kernel due to its use of mainline kernel
constructs not present in the setup kernel.

v/r,
dps



