Return-Path: <linux-integrity+bounces-9579-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIH+MmOnB2rP/QIAu9opvQ
	(envelope-from <linux-integrity+bounces-9579-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 16 May 2026 01:08:19 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D5B559397
	for <lists+linux-integrity@lfdr.de>; Sat, 16 May 2026 01:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B509300C991
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE863F788A;
	Fri, 15 May 2026 23:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VjGrlCzq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7183F6C3C
	for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 23:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778886356; cv=none; b=ZSFRNDSh9PSpu+YElSDdkQf9LyHSEOYkVJSw2Mi+aulwRhwDJqvMfEsnaax17e1sRZNUa7VlKY1kdzSjYrQpBjXcs97c+3Ha8imfhm810UHky+28NNKd/jDMFR7LofNVGJumcNABRLzT3msnBSlOUqM+Sd6bfHERwlTTDqmaXjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778886356; c=relaxed/simple;
	bh=Efl9eGRUvRUSMKgeJbT5viBCvrEY9UH6Bmru0k/SItc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqo0jC0Qw4nGsfa7zO+ia/Ylgcc+jxD5ZQpNmQin+5O+hqhu/ObieWZ4LURM4pDL+Ob+qNlPJGGQvY1NXykmxisBb/6ns0/bq8+aWTsnEXWY4vsetdawpXLVIQopS6HB87nMTL3mET8lnUrnbFdBuSEJPLEvezyP1t95zvJ8zf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=VjGrlCzq; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8b9f2295a9dso4792136d6.3
        for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 16:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778886354; x=1779491154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D7nklUCScqv2NitQOcHmOlp1LpHmTXVfX8MzcU0yUSA=;
        b=VjGrlCzqH+mUAoPngtAUQe7YHCLoMhJG1fiIHQCxDz32VqGSoi3tCJsSFgtxVM188x
         B1I46C1Bx8QQzngPeK7/vA6iCd3CpAt8owSY3Qk2nCELXf16tY5ju7NULVy1Bs7iU46b
         28cIKMzc8eLyongezBRMR3VmA7o08PT5Z7liMeIlm/EM5roeQ11TGTFe8o8pwEKpBde2
         Fsx6ppNY5QSyuK/iYmvX45MZQEdYg6mnwLgbubPjDSn55db4gxyjHGOWFH4aH1iAqKvc
         eCuseZOZeg7y7OGNf1zOhuZ+/BsETUblnI4pCL/GGB+CYb73uPazR/wccxYK74Yh0spW
         gQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778886354; x=1779491154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D7nklUCScqv2NitQOcHmOlp1LpHmTXVfX8MzcU0yUSA=;
        b=hzJNx8sn9ZCzkmh63cfgLxkthQxwkVCTjr12NwSgk9xmO60M0ykNAArdnxTkSGqxC0
         azUhakgTow3CovEPwklFApGFzJGMu7MDvnuZl5m41OPKM5OqqqMDCwN47YB+fs8nS9K4
         OwQappkNVTgx3WRrKBDd5+wUhZuBeOI1goF/Dks1t/kn+fqTd5KVNQlgQrtECqEA/jhh
         G+ocs56iHWD6dZaTsQhBQsM+l6m4RnmyTsGLUnRam9uKiWDyYuS+TPzjv0nCDrELVD54
         BVFKK5IrSz7UoG1ahMF1Ta7UhLA4TDkr98lpLRW8tYlljiU7CbFDyzXGa0FGPFIxqe4T
         GDDg==
X-Forwarded-Encrypted: i=1; AFNElJ+vajw4XeDcv9fP783FoP/rnMbKWn/l2E62wxzMGbZVOjqcbZ6bQMkbyIWjLK0SW0H6nJSwhZwxM1WUA75wVys=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhLrdyrE4034voHkqgmMA87MpelVj5EqQ1bXKKcYDwyGN0kqu0
	J9iCT439MPQo8slT6hZGGxgXtKS6ow6pD0kMYrnrR6PjuuBmvB7yD49hQk6QEyrjngI=
X-Gm-Gg: Acq92OElCwlB7NrZywYwjqubeXDlC7tq3yrKoYKgxRVEWdVFsL92RLpQqpc1THAmLgr
	gHLFqOBVvKr5g8VbwmEAWJl5LVQXiZ925W/h9vc1O8UWtuzY9FX27lAYMM3lpDVk2yMfqvJiYhz
	RujJQEJJSayLybD/QVqLYLD9Lz0XkEjCELjbVGUutuggQ++KVo/2ulqLK+ZJerLjsTHvpL91aDN
	lhmCY9jJmNAfFhUClGExmfISQyRwbSawDO0cBxZYu2IgZj1yCgRxyVWSszM55Y3x1UXDJtS0zI9
	8nPmf0rU3y3Hxg8soxOUBeySAWJKtybSlB942dFvsiYbaMcqtqUvPUwgHIgzSx+OSzuBAwrTDoq
	0VfzS71RdoGBpcjKMbPlt7BYIHnXImryn8BGwEo4X2upocnTxOHQd08WEzjOXAMA/YRN17gZi2F
	FVpscB4toWkK+9w+LlVUJe2/eYiK2m2xRC8jZxesRPQOfeqOMNTThAvC+jD4rcLDU47gVYeMO4/
	OdMIQ==
X-Received: by 2002:a05:6214:1c82:b0:8c2:b36d:4fc1 with SMTP id 6a1803df08f44-8ca0f66afc4mr87385476d6.14.1778886354080;
        Fri, 15 May 2026 16:05:54 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90c374469sm64030376d6.49.2026.05.15.16.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 16:05:53 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wO1bN-00000008GrB-0jOE;
	Fri, 15 May 2026 20:05:53 -0300
Date: Fri, 15 May 2026 20:05:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Ross Philipson <ross.philipson@gmail.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org,
	iommu@lists.linux.dev, dpsmith@apertussolutions.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	dave.hansen@linux.intel.com, ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	luto@amacapital.net, nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
	ebiederm@xmission.com, dwmw2@infradead.org,
	baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
	daniel.kiper@oracle.com, andrew.cooper3@citrix.com,
	trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v16 01/38] tpm: Initial step to reorganize TPM public
 headers
Message-ID: <20260515230553.GO7702@ziepe.ca>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
 <20260515211410.31440-2-ross.philipson@gmail.com>
 <agemXwxVb9jvAbYM@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agemXwxVb9jvAbYM@kernel.org>
X-Rspamd-Queue-Id: 48D5B559397
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9579-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,lists.infradead.org,lists.linux.dev,apertussolutions.com,linutronix.de,redhat.com,alien8.de,zytor.com,linux.intel.com,srcf.ucam.org,hansenpartnership.com,gmx.de,amacapital.net,alum.mit.edu,gondor.apana.org.au,davemloft.net,lwn.net,xmission.com,infradead.org,oracle.com,citrix.com,googlegroups.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Action: no action

On Sat, May 16, 2026 at 02:03:59AM +0300, Jarkko Sakkinen wrote:

> LGTM
> 
> I'll hold on from actual tags up until there is some consensus with the
> patch set.

This patch set is huge, and I know there is alot of interest now in
DRTM.

Can we please split out and progress the TPM reorg mini-series at the
front?

Jason

