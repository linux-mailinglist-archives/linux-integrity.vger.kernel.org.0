Return-Path: <linux-integrity+bounces-3920-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 906F99B2521
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Oct 2024 07:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0D831C20E98
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Oct 2024 06:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5609918DF80;
	Mon, 28 Oct 2024 06:14:58 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D9E18C90B;
	Mon, 28 Oct 2024 06:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730096098; cv=none; b=UNNYRq0HlSEIGUHWKg2nyPZhQJ7sewfOVeNzlMCObUnvFMP1oYyKH1jjHobY0o07Uq2URg7MisTMgGyeXaTKX6zgv6Md/L85GkWSMqEa5T73KSeuuTWF8A/4dRBtp8elVczfgbOFtXBalIFLFnzrDin71X8OkIjNEVzY0uypk/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730096098; c=relaxed/simple;
	bh=CwFGkITsaLdwGZQxZSE/cRB1x+IdHo2N7RzH4GDuCGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XYCc9g62w53K8phodsBnXpYeD+NKheiitfr6bCnB5DbJa2rvxLZlmpqXCnO1uNN0M0hGhOLmFnPwVfTj60ugoT/d6xH6XaBp0m1kbXveLRBpUwda8oVXEuXOSRRJDGAE6uYxK9r80YIP5OqDIEHBmx35zafh+MlozG+u5DRy1xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5aeeb2.dynamic.kabel-deutschland.de [95.90.238.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id CAF2061BF4882;
	Mon, 28 Oct 2024 07:13:37 +0100 (CET)
Message-ID: <88bfa0f8-4900-4c56-bd23-14d3b3c7de85@molgen.mpg.de>
Date: Mon, 28 Oct 2024 07:13:36 +0100
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/3] tpm: Rollback tpm2_load_null()
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org,
 Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
 Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 Stefan Berger <stefanb@linux.ibm.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>, keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org, stable@vger.kernel.org
References: <20241028055007.1708971-1-jarkko@kernel.org>
 <20241028055007.1708971-3-jarkko@kernel.org>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20241028055007.1708971-3-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Jarkko,


Thank you for your patch.

Am 28.10.24 um 06:50 schrieb Jarkko Sakkinen:
> Do not continue on tpm2_create_primary() failure in tpm2_load_null().

Could you please elaborate, why this is done, that means the motivation 
for your change?

> Cc: stable@vger.kernel.org # v6.10+
> Fixes: eb24c9788cd9 ("tpm: disable the TPM if NULL name changes")
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>


Kind regards,

Paul

