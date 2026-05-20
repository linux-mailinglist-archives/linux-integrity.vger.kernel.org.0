Return-Path: <linux-integrity+bounces-9608-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAPVM0IWDmpT6AUAu9opvQ
	(envelope-from <linux-integrity+bounces-9608-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 20 May 2026 22:14:58 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C9B59955C
	for <lists+linux-integrity@lfdr.de>; Wed, 20 May 2026 22:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4028E300F5EE
	for <lists+linux-integrity@lfdr.de>; Wed, 20 May 2026 20:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FDF36166A;
	Wed, 20 May 2026 20:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="fk8v3jVU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sender4-of-o51.zoho.com (sender4-of-o51.zoho.com [136.143.188.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C77361662;
	Wed, 20 May 2026 20:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779308095; cv=pass; b=sqbOxPvW/xL43YjWAfpcQ3mdxbDL/bW8n0nDAkmJzkFlkGecCuDf2n8Ghk3EJxRKKE0DjuI1+MmGIcVU1ftNdHDB39MzrtlxIe2p9JYfcFuK5I/fg50Zxu0kdnRNUhS/LRygkkO/UQ6g1wMR+0CZhTfIzCOa4Z3Ni8dOjO4ODEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779308095; c=relaxed/simple;
	bh=3sQXcyhBMV7Fy/iPzt6jvnFx2tQnSeys6xAJHBKj0uM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jxixcqktCwQ/ytHmbHWg4L1NCNV//rSlCxEyq8lCIQCTqwP9Dq2EHfCWI/cysDjh1dGbOiHQlYfdWKGHHwV5zd2JhgrUt2UUh6Wqnw8tGVFc4LqNW0aI5x0hNb0kIzab0sLJmtRNCMkUPDNdugAEB9kN6f55kud9aaJZ3IyvP74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com; spf=pass smtp.mailfrom=apertussolutions.com; dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b=fk8v3jVU; arc=pass smtp.client-ip=136.143.188.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1779307955; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=F7zGj1KM1ljluaeAwqLEa2lH3pOe1//+GG7dZFuLI/e7EOJSEDFz7r/ZwPSXFaSPBjGDaBPn0evtNpBB0l5HBIb1P/fUeLabzdyhNHqLjeuGkLBgHLLVm5EQYbq04+VcicZG0jspNbLDSTyh8zBgXeTRPE3fhkuzIUVlkN+Kuec=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779307955; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=DRXXEptyfYW324C3Rd22g0Bz5yZ2Gjy/Wsltr9WZ4UU=; 
	b=hXusYhMz5XryhCubUebQISLI6+Ine8ivFgl/WZxwfusR8AzqJt1V+wVNJ1i9TWR7yNFDBQ9P1WW0mt6jlGz1g2pHHPmso0vwRGEu9eaVKtrXAo7S1Y5RKpyMKe+t9oPlp1nQNrItH2A1Q5SC1l1Bp1tYeBQF55St1jRYRdhYFng=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779307955;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=DRXXEptyfYW324C3Rd22g0Bz5yZ2Gjy/Wsltr9WZ4UU=;
	b=fk8v3jVUl1vMDS7ypit1OGgSRJCwy3CYGZ7bOP84cJvHacZTycXN7FVoTp+cYxXJ
	4LosRO1EMAetAFMW4Gciwa6SnlryPlJl52AjnXmy+3NRWfGKGJgbzuGNwjhNhs3rEHq
	zTT4q6Z7O0CO4d0W44EH8K4c898wh3G/6FtiBfXQ=
Received: by mx.zohomail.com with SMTPS id 1779307952071689.0219932508874;
	Wed, 20 May 2026 13:12:32 -0700 (PDT)
Message-ID: <a5d70928-5d86-4439-a177-e5182552b3e2@apertussolutions.com>
Date: Wed, 20 May 2026 16:12:28 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 01/38] tpm: Initial step to reorganize TPM public
 headers
To: Dave Hansen <dave.hansen@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Jarkko Sakkinen <jarkko@kernel.org>
Cc: Ross Philipson <ross.philipson@gmail.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux.dev, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
 ardb@kernel.org, mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, luto@amacapital.net, nivedita@alum.mit.edu,
 herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
 ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
 kanth.ghatraju@oracle.com, daniel.kiper@oracle.com,
 andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
References: <20260515211410.31440-1-ross.philipson@gmail.com>
 <20260515211410.31440-2-ross.philipson@gmail.com>
 <agemXwxVb9jvAbYM@kernel.org> <20260515230553.GO7702@ziepe.ca>
 <8f8328d3-a7db-4a64-82f8-1e0e3eff93cf@intel.com>
Content-Language: en-US
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
In-Reply-To: <8f8328d3-a7db-4a64-82f8-1e0e3eff93cf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[apertussolutions.com:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-9608-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[33];
	DMARC_NA(0.00)[apertussolutions.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[apertussolutions.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dpsmith@apertussolutions.com,linux-integrity@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,lists.infradead.org,lists.linux.dev,linutronix.de,redhat.com,alien8.de,zytor.com,linux.intel.com,srcf.ucam.org,hansenpartnership.com,gmx.de,amacapital.net,alum.mit.edu,gondor.apana.org.au,davemloft.net,lwn.net,xmission.com,infradead.org,oracle.com,citrix.com,googlegroups.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 79C9B59955C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/15/26 7:10 PM, Dave Hansen wrote:
> On 5/15/26 16:05, Jason Gunthorpe wrote:
>> Can we please split out and progress the TPM reorg mini-series at the
>> front?
> 
> Yes, please.
> 

Yes, we will split this out, address the Sashiko comments, and work on 
getting it out next week.

> Any way to break this down and merge in more bite-size pieces would be
> better for everyone involved.

I went through the TPM only part of the series and only one commit was 
of substantial length, note I am not considering those that were only 
moving headers around. That's the new buffer allocation patch from 
Jarkko. We can see if there is a way to split it up without resulting in 
either unused code or breaking the TPM driver.

V/r,
Daniel P. Smith

