Return-Path: <linux-integrity+bounces-4527-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9DEA04000
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jan 2025 13:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDF541886B1F
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jan 2025 12:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123AB1EF088;
	Tue,  7 Jan 2025 12:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="oAAdNDJE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA561EF08D
	for <linux-integrity@vger.kernel.org>; Tue,  7 Jan 2025 12:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736254578; cv=none; b=OONPU/Tu11zwcGs2U7hlp9KZbG7W3bExsc2w5MO4J3HUJNvtvZdKpusvxkKpSukZM8rN403W1LbPRgTZ1Uj58bfWmstyGnrjxTBhWYRgXWiJz0oTJ2u1N8nlZlp1Mw6p1/3SBOq3Ha4ApvL/eptPJPz3nCY4lvVDyfXI/b2dBfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736254578; c=relaxed/simple;
	bh=mhjI5XJs+wlmeptweqROi6JQ9QOeOFdceKqB0fLjzng=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=aYqPCSFUnEOsJN3qXD4Bpbe0lAEi7x2sbyNyx5PY0Em+asVRR8LaVsAV6HNMYxpW8NdrOTGSe56THV0PqajtczdmNr9YtCAcBi9vIyfAJ3hb21TfUDannSYRqmqvvLZxSm1j2LcVyxeZQ16vZRTuOcsnrN13TRynmCIgsocK/vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=oAAdNDJE; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43623f0c574so106807295e9.2
        for <linux-integrity@vger.kernel.org>; Tue, 07 Jan 2025 04:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1736254572; x=1736859372; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3ZCQbwToICSm537L8Sy2gP7aNDk3KXPLLCsJPGfnhw=;
        b=oAAdNDJEJ8VtwnjbngputK7jhZAlRPGLevRm47nr5NWcX4W3pQmbLFrSLLL2pEbRue
         t1nHYeufDY0YIMmsDoqKG9r8XJw/03JMsfHIZu1tC0x3paVyDu1DxydjzNuR2PXsThCs
         zCZr0ubOJsetBrE+lMmnMNC9keQjqzGxLB6Og7IHc5iF/tmvVlPMpaB4ZtvnGtvp92oR
         j2+iYg8RsiNrBUL/yLVmlapCgyXtqN1dJpuTthIbSTlelmM3T2MznXakUDsp5vyxFQY+
         hJ/ojDCeHk15UJvDatgAO13Up6/n5hpJefqI/1y483A14q4SsCX8jckDlwTNlaODXEhy
         0JFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736254572; x=1736859372;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u3ZCQbwToICSm537L8Sy2gP7aNDk3KXPLLCsJPGfnhw=;
        b=hT8PBwtjQzdFlw+CN2awnEtAUdvQojGpqxb2YILWTGIOWZ+5JP8M9wofxsaXccqBgn
         U7fAX2DnY9E7Ke3UEsGyKjXjDDdQ2w6DnaEacY3OyBLED7g7bi5N3WOTwTKSOQSk4jE1
         J/7yxxGRcCwd8Qubvd9IzUwQ9//5a1XUgrKyEJ9WFH2PRwcZnzreuMcpMr+N4GYB220I
         r6IT8EiaPlp7rCKHWGbdgx66FcX/AnrxrZdU8rHkxotIUok0EsLp5g/C0GO7DidLRYde
         O5AAg0nHaVfQG/Rdz9OPoiqy/EvPlXs8Dpg+/Qm5bDqj8rzxzu07k6b8SltifeVTAjAV
         PrDA==
X-Gm-Message-State: AOJu0Yy84o26/zYgfuVEi1kJUHsYymRySDCwuqRmiPFMLVputXeRC+DZ
	yXnB7RBdxpHs5ZqnDalCzs80miVpEIajCQolmvqz6J/Mae15IIBsXw72BBKXIVs=
X-Gm-Gg: ASbGncsSRCdzVdCZQhrbyW0RfJS6mD1cWOOKKNUe+7+ktyTXkeuG8NmKd5CfR19FzXU
	NL34RgR/rOWPXbK3Z5+A04cfb+bvZrEAPYxMASQeIr//2dEn1IPWCuiP/uQ7DylHqhorH8FjfIj
	6k8fR44K70JjUyYasD7l4UkzYuPGG6W7A/lcRMljLW6G+2F4JH1YPJSZeFhRVVcmNPxnCqw8hb9
	O/g8O7nbU1vToorv/VOGTpAoFVTN4BVu2XRrwUScdvjilRSYvNOJIv7rQzrBt6tqDt07pg=
X-Google-Smtp-Source: AGHT+IH3LnvvjrofmboXcdOA469qCM6U4NR7fF54KLrYPLcSCkDti2tVbLL3RQaJvGouHlnnaL3mEw==
X-Received: by 2002:a05:600c:45cd:b0:434:a7b6:10e9 with SMTP id 5b1f17b1804b1-436686462f9mr571258605e9.17.1736254572516;
        Tue, 07 Jan 2025 04:56:12 -0800 (PST)
Received: from smtpclient.apple ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a546e822bsm24831226f8f.22.2025.01.07.04.56.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jan 2025 04:56:12 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH] KEYS: trusted: dcp: fix improper sg use with
 CONFIG_VMAP_STACK=y
From: David Gstir <david@sigma-star.at>
In-Reply-To: <20241113212754.12758-1-david@sigma-star.at>
Date: Tue, 7 Jan 2025 13:56:01 +0100
Cc: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
 "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
 "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <CA61EE6A-F2D5-4812-96D4-4B1AF3B8B3ED@sigma-star.at>
References: <20241113212754.12758-1-david@sigma-star.at>
To: sigma star Kernel Team <upstream+dcp@sigma-star.at>,
 James Bottomley <jejb@linux.ibm.com>,
 Jarkko Sakkinen <jarkko@kernel.org>,
 Mimi Zohar <zohar@linux.ibm.com>,
 David Howells <dhowells@redhat.com>,
 Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>
X-Mailer: Apple Mail (2.3826.200.121)


> On 13.11.2024, at 22:27, David Gstir <david@sigma-star.at> wrote:
> 
> With vmalloc stack addresses enabled (CONFIG_VMAP_STACK=y) DCP trusted
> keys can crash during en- and decryption of the blob encryption key via
> the DCP crypto driver. This is caused by improperly using sg_init_one()
> with vmalloc'd stack buffers (plain_key_blob).
> 
> Fix this by always using kmalloc() for buffers we give to the DCP crypto
> driver.
> 
> Cc: stable@vger.kernel.org # v6.10+
> Fixes: 0e28bf61a5f9 ("KEYS: trusted: dcp: fix leak of blob encryption key")
> Signed-off-by: David Gstir <david@sigma-star.at>

gentle ping.

Thanks!
- David


