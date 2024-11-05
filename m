Return-Path: <linux-integrity+bounces-4022-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 105A39BC1E1
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Nov 2024 01:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7EA8282479
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Nov 2024 00:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C893817;
	Tue,  5 Nov 2024 00:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="Gkou6P8m"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sender4-of-o51.zoho.com (sender4-of-o51.zoho.com [136.143.188.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D604383;
	Tue,  5 Nov 2024 00:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730765612; cv=pass; b=i0vO8i2VxfriJKU2p5tecyND1v6dgvQV6HTJejAcpudGA7/alA4FTsUcXhs58zzjpVXOV+eAlFA8Wugf78yV+AwmLlp+72suRFS2JleAAAmIkJTHI2aGMpZ8p9UJcLHBadWnJTYqtDyRQRxniY13KZvWhol4VtdDRF3QA+NTsvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730765612; c=relaxed/simple;
	bh=4Hkv8Cq97EpX+KYZJG+J6idfjLrRvz45ssxKBWA8KK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r6zGWfwCots3qevvE1/eEKMAJU6Riz5gM46CzCMqEjZ+3PuKQsbE6AB9TpsIEckv+r6bowWyQzBdT/ner3o3cRm3BiKVvXpdlDOshJpATrQGqmhKTDrtYGXRt/hdrh0K0BpunoTxp/Q6xUnAUOfxXm+XbqbWEk4hH7i3rd325J4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com; spf=pass smtp.mailfrom=apertussolutions.com; dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b=Gkou6P8m; arc=pass smtp.client-ip=136.143.188.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1730765597; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aeDqGcNOCu2sSM4TiVnmCvMXGaazxZKcoIAWAcH+X+6t7Phvl2+VBa/LJnwyooDjYgGsvtnO0uYd+7NVwId3nQCjJqIoYmXUyHw+7P+khBcwDvBrL2oW7OqwP338zQlbi8ctpzj0klTt5s+F5JE43Zfs764/lJuxCe7u4rkbSRU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1730765597; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dM/TgvdO5PoMQPumnanriKIdXf25AB892phFjkmWGtA=; 
	b=YXkn+nrZqGpovkia++qnFoCqNpbL0J7CZbKOX8JlUGyeKMLN364PA5wcBWBNLuBwomV02N+vhsIYEHobhTg5rRBsq8SokPITUhHtiAnnlEdeC1JD0rWxop+abx5v3YLIdEMKOXw3fFpz9ZmtfJXajyuE+YLn3Zzi3shUNiOACQY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730765597;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=dM/TgvdO5PoMQPumnanriKIdXf25AB892phFjkmWGtA=;
	b=Gkou6P8mTgJyYXmM8FEa4EkkSOjhiPuDSsnW/Dkh2gPIajIkrS0tq8Yzp8obBs4T
	MttM67a/DzLXPxNTfvF3fe1wZaJbwzeU3+ws0gs+62akgpaTRGKX/TV0X7URmoNHk6L
	yinzhVsPyzDuxiUKKo2euLuPiHn5oRV+5/rGh02k=
Received: by mx.zohomail.com with SMTPS id 1730765595655502.9682001690933;
	Mon, 4 Nov 2024 16:13:15 -0800 (PST)
Message-ID: <3f7bb7d6-3410-4e04-b6fc-6fdc26274cfa@apertussolutions.com>
Date: Mon, 4 Nov 2024 19:13:13 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] Alternative TPM patches for Trenchboot
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 Ard Biesheuvel <ardb@kernel.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
 Ross Philipson <ross.philipson@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Huewe <peterhuewe@gmx.de>,
 Jason Gunthorpe <jgg@ziepe.ca>,
 "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, trenchboot-devel@googlegroups.com
References: <20241102152226.2593598-1-jarkko@kernel.org>
 <D5BW0P0HH0QL.7Y4HBLJGEDL8@kernel.org>
 <e745226d-4722-43ed-86ad-89428f56fcba@apertussolutions.com>
 <D5DCPWBQ2M7H.GAUEVUKGC3G0@kernel.org>
 <CAMj1kXGd5KAXiFr3rEq3cQK=_970b=eRT4X6YKVSj2PhN6ACrw@mail.gmail.com>
 <97d4e1a0-d86e-48a9-ad31-7e53d6885a96@apertussolutions.com>
 <CAMj1kXFEJYVs7p6QLEAU-T+xfoWhkFi=PE9QpJ4Oo4oh3eM38Q@mail.gmail.com>
 <7b324454-bc34-4cc4-bd12-99268a543508@apertussolutions.com>
 <3bc70b659c1c86c0f08c6d91a6d894ce58825e04.camel@HansenPartnership.com>
 <102f7de4-a2d0-4315-9bce-6489504180fb@apertussolutions.com>
 <11eb20711f597b355c38abfce54ccff7f68fa5c9.camel@HansenPartnership.com>
Content-Language: en-US
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
In-Reply-To: <11eb20711f597b355c38abfce54ccff7f68fa5c9.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External


On 11/4/24 15:36, James Bottomley wrote:
> On Mon, 2024-11-04 at 11:34 -0500, Daniel P. Smith wrote:
> [...]
>> In case the question comes up from those not familiar, the kexec does
>> an GETSEC[SEXIT] which closes off access to Localities 1 and 2, thus
>> locking the DRTM PCR values. It brings the CPUs out of SMX mode so
>> the target kernel does not require to have any knowledge about
>> running in that mode.
> 
> So, to repeat the question: why a sysfs interface for setting the
> default locality?  If I understand correctly from what you say above,
> it can't be used in any kernel except the SL one, and that one could
> run permanently in it, so there's no requirement at all for user space
> to be able to change this, is there?

I responded to Ard this morning that, "If the slmodule is able to set 
the locality for all PCR extends coming from user space to be Locality 
2, that removes the current need for it." Where "it" is the sysfs node 
for default locality. This series does just that, so in a more direct 
response, no, a writable sysfs node is no longer needed with this series.

v/r
dps

