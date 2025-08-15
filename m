Return-Path: <linux-integrity+bounces-6867-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 221C9B28578
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Aug 2025 20:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1A543AF57D
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Aug 2025 18:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAA4307AF6;
	Fri, 15 Aug 2025 18:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="vhdLnbBA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06921D9A5D;
	Fri, 15 Aug 2025 18:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755281082; cv=pass; b=Iqu3R5XtXkGFdq5zmvVjiKJX0PRjv7jttbAXFng+4sey7wabVdiU5SC/3DRdSz/j4ioHER1nOTaiN6nfgfQJQDjXHyviZUDcrOjOT1U6vyHMYEaqUwtrzLneEAT2B0J/ToQfvbHMaR/bNJpOn9161W2yl/oqx0xBCNY0XMdObXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755281082; c=relaxed/simple;
	bh=N/68Fbwxd3zb5cagkcweb7ryFa2TrDUnrhkJZ9v3sJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LenjxkXwTFwVHaYmFS2rv80SazrVYYBqj+AUrY+teGOql75QIZZbiuNt6OG0XGFreh3yCK32oiMW98flF7DRpHzVDZFbtSETM6UpLp6Kq7bTvufOtTAAe1j2umJ3bAb4efbZwGfMTOLg8zgkctwaZsQNDhwIEM2Ju5wr+pF8Dro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=vhdLnbBA; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from localhost (83-245-197-149.elisa-laajakaista.fi [83.245.197.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sakkinen)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4c3VP83B2hz49Q5H;
	Fri, 15 Aug 2025 21:04:28 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1755281068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4pAhnMtIGVio/fL69TSSu91JNUUbAIp6omknr7h9bO4=;
	b=vhdLnbBASZwSC4HziNYP6aK29YTBiYEBcemLCi6keAJYTANzverQlFsjNOOgaUD1//2jm2
	YqRriHhBknUbo94AoQVRpI0pDafuCQ7udb5e9oZBX3Of4ittfG7+min+42etFsITasXyAJ
	+GWEi7mNRp18E85FhudQVOPq6N5LdFccbCK69YS1QfBlT4g893n1fh3lqJCUMkalBQxAML
	yW7y6a7cijQ3kaPUlPlzXE+fZaIKZbAc0h7qT1BGrJG5MDDt1g2U+O1BAiMZFSzReVFSDF
	iG3O3mxTpdgLuatZ3gQ0ky1xmvlBCB+VbQ2TUpHZFVwEbgjw1OjJmrolO7Dcdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1755281068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4pAhnMtIGVio/fL69TSSu91JNUUbAIp6omknr7h9bO4=;
	b=Ugp9DTLH/Lefi1IG/1GVSOuE4IzNt1M+TxZKXyjMzvqpUvmfuxMVzQvjVzVEGB76ohtIT/
	LZkYved2TtPs8PUbTnShiNnOI+QCr/N+Wb1/UETJnkYIWu0cmgrvJnthxbBkhmhbeE6T9/
	QH2sQljJox5AcP098rP4LDvfXn1VJBP5H0CiTylzuO/dw2eQemH1m3RU+d6RD8R5JuA4Vx
	HYy4m2OddZRrcCkePnYtI5LycPRfsLaAFO9KREtdrzPnI3F+u1Ih6VPiQh0lOwSaOG0vAp
	/dPkv55CFmVg70r250ggtS/XQO6jA7DGWRsZrGIDDT/eqqzYlIKq1Gz15c5dzg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sakkinen smtp.mailfrom=jarkko.sakkinen@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1755281068; a=rsa-sha256;
	cv=none;
	b=PuPGtYSuz1o4ve2WhhaqbxG/EIl+0/1DRlwPzVsW4QJc+kmdnPdkHJgLHfpVNizXqQduFt
	n4i8r4fG98mxQavajmhJv1hfzf1eC9OWCVTP7EtRQN3hlEhhZj9zhG6sfuAIGm2M3JjoMa
	J93SFDEtKv1m8C8hkvqNIgyR1k4licD5zMQCO8ez3gmrgaOtx0L0HKrR0wv5Qcz3ehxC01
	0kGHvxZZm+Pzz9bSEi/fGm2IZYTj+tdOdX7kHhMYadbo5y1jaEnOeRwTWlVpfg0dzKZdDb
	NoLuAu36c4VzRRx4b3CwQgMXPi7Z+mjpDll7H7hmnv9Veax2YKLSWnO2yHWJeg==
Date: Fri, 15 Aug 2025 21:04:26 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Chris Fenner <cfenn@google.com>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: Disable TCG_TPM2_HMAC by default
Message-ID: <aJ92qt6oSYyRYPZG@iki.fi>
References: <20250814162252.3504279-1-cfenn@google.com>
 <aJ8iNLwlf4PAC0h1@kernel.org>
 <CAMigqh1RTVzz0ffY8M3mZuc7NDaBKpMmCU4q0LuNyM2eAi+NFg@mail.gmail.com>
 <aJ9fy_sO6tza9qLF@iki.fi>
 <CAMigqh2=Kmnv_rrT-gBtESSXtnMrxU=VJdrYE6_9NGhKBN+ZrA@mail.gmail.com>
 <aJ9ySGv0JZ0DiNgf@kernel.org>
 <aJ9z4OlwvFdEA2Q_@kernel.org>
 <aJ91KX97WVOQ3nVk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aJ91KX97WVOQ3nVk@kernel.org>

On Fri, Aug 15, 2025 at 08:58:06PM +0300, Jarkko Sakkinen wrote:
> On Fri, Aug 15, 2025 at 08:52:35PM +0300, Jarkko Sakkinen wrote:
> > On Fri, Aug 15, 2025 at 08:45:48PM +0300, Jarkko Sakkinen wrote:
> > > On Fri, Aug 15, 2025 at 10:06:36AM -0700, Chris Fenner wrote:
> > > > On Fri, Aug 15, 2025 at 9:27 AM Jarkko Sakkinen <jarkko.sakkinen@iki.fi> wrote:
> > > > 
> > > > > I'll with shoot another proposal. Let's delete null primary creation
> > > > > code and add a parameter 'tpm.integrity_handle', which will refers to
> > > > > persistent primary handle:
> > > > 
> > > > I'm not yet sure I understand which handle you mean, or what you're
> > > > proposing to do with it. Could you elaborate?
> > > 
> > > Primary key persistent handle.
> > > 
> > > In tpm2_start_auth_session() there's
> > > 
> > > 	/* salt key handle */
> > > 	tpm_buf_append_u32(&buf, null_key);
> > > 
> > > Which would become
> > > 
> > > 	/* salt key handle */
> > > 	tpm_buf_append_u32(&buf, integrity_handle);
> > > 
> > > And in beginning of exported functions from tpm2-sessions.c:
> > > 
> > > 	if (!integrity_handle)
> > > 		return 0;
> > > 
> > > And delete from same file:
> > > 
> > > 	1. tpm2_create_*()
> > > 	2. tpm2_load_null()
> > > 
> > > That way the feature makes sense and does not disturb the user who don't
> > > want it as PCRs and random numbers will be integrity proteced agains an
> > > unambiguous key that can be certified.
> > 
> > E.g., for example that will unquestionably harden IMA exactly for the
> > same reasons why some user space software might to choose to use HMAC
> > based integrity protection.
> > 
> > At data center, there's guards and guns but for appliences, but there
> > is also the market appliances, home server products etc. They are not
> > mobile but neither they are protected in the same as e.g., a data
> > center is.
> > 
> > This is not to admit that right now the feature is no good to anyone
> > but in a selected set of use cases with this modification it would
> > make e.g., IMA's security *worse* than it would be with the feature
> > enabled.
> 
> One product example would be "blockchain node as a box" i.e., it carries
> momentary value inside. I could imagine this type of products exist or
> to be created (especially given proof-of-stake blockchains).
> 
> In such product, you don't have much to measure but you wan to take all
> of the security that you have to harden the protection of that small
> amount of data.

I'm happy to make patch next week for this change too. So probably this
where I align myself to. It's just the best average IMHO. Everyone gets
exactly what they want, right?

BR, Jarkko

