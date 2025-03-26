Return-Path: <linux-integrity+bounces-5443-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D06DAA718A7
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 15:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 851FB188D6B5
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 14:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14021F131C;
	Wed, 26 Mar 2025 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OsyVIHS1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DEA1F0980
	for <linux-integrity@vger.kernel.org>; Wed, 26 Mar 2025 14:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742999646; cv=none; b=ZPqaxoAdhOU9RgF+6/1l/4HKpvp9uBlJGEtutGaYwRn/EbfayxSVCKFJa8Uh79PjQZf3idQ1AE0ZCgOUGg1zcVpxssdglFqJL6i6eMIwULkGD1Ovqeaprn3pYgg5cENpO7EOy+djnYLVY/kkpmD2r6gEyR6ZxVuCj6fYYmhalDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742999646; c=relaxed/simple;
	bh=X9K0ZiIBbyvbHh33ELRxPX3WXyDf6Rv/bbUWC1l6rkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nq7fK+Tb8emaDIxkGWzs1hhmTjKo65/dQiE16lgJzeLFQfwA8dzbF0ix4GD7U8O5i9SuAnAEfyttBjJcxSX+NJ4gCUFlRrwhP7gvVXvz78vZnETKyNapCqx9vIHtib78fFxB6uzpvvrtDqIHh5AGOHxAIIKoUOK53PusgVJrixE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OsyVIHS1; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c5b8d13f73so640247285a.0
        for <linux-integrity@vger.kernel.org>; Wed, 26 Mar 2025 07:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1742999643; x=1743604443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X9K0ZiIBbyvbHh33ELRxPX3WXyDf6Rv/bbUWC1l6rkI=;
        b=OsyVIHS1DCbkohaT8GNSyvOIwoQ7zn3xRt6+wTj3Y+r9XYdSdLiD0qgXXGl/89DTtG
         e8pJLVNtLWtI+dWmUpwX1e+jGg9HrKAStwSJt3jQTBSsJsA0LCGyiZkuQz66WvG2n8P1
         UF+0MU8y100y7T3SS/OEE9ueHxOh1TAWznFfI7xd7tAwsXwbd0BgUf4bnx8/Wv1lhzcj
         hEu/D3CZTPHqVasmWzOsZqb7kIJ4a2VW9+WIDQnCdOiGGat9uqCZPyegJZ3touewr+B1
         PQIqlP05CMceZZpGkEkEg66AmYZSuyJSIJYrpVsq4zjzmlfbz4+lr2k66W+gOdFeJXq8
         1OZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742999643; x=1743604443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X9K0ZiIBbyvbHh33ELRxPX3WXyDf6Rv/bbUWC1l6rkI=;
        b=mUJO2IqdwUUl55na/SGIPeX4A/Naf3Sw/BF830KCNZthsKgKZ/QhoYqKyk5iaQAgp+
         oR/8F6UMTE4nNpBfOAB8CRAHjxNixdZ0+Y6JCPRmTtesEAgsEb57FCGh88m1hsiraVGG
         ZttoeWQ8tPNZplQPHA7VQVklxu+57jSfoAGY8LDFZbWDCIfJcOuWSCNglt15j9crJajh
         OLi9mWRy3K/oem3zlDVOahc5gEZAepV0koQOt/VO9ypEVHj6pwQ01Fler6GwlEWj1oHG
         JR7kkYkEkcAUL6rvtJuXYFbpgwdZzMN2I1ca47uNIM6zt0b6DUMOoqi+HyTdo1onEaME
         dQXw==
X-Forwarded-Encrypted: i=1; AJvYcCWbZnIklQnJQ+n31Nk6zx5pbYIBmOA0xTLQyqeNgp01/wuyPa58DzSGSP4xei7wKHUAA4I5Bh0zxaOhteWrF1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzODZiq8q+rlUCWtzVeiX1OS4fY7RnZI4Zxx7OoTPnTCP8W8BYw
	gAiCFkbwTvLVRbAJD7Gb2zrbiVB07PEvigp81Oa6pGjcfL6rYO07kSs7m9eUN2E=
X-Gm-Gg: ASbGncv7mERrr5FjQcBUVE8VartsqcHrV9FpqLdf+3zWGEzvahj9v0BOp/BhwQxr23v
	CpCZGu+7CdmfptS8owmQFJgA30R6VnqMnMfN8OhBK9s7WeesjAnsCwY4DBn4eIIIkrebkh2OTHK
	PGgN63C04VlEd+1cluWn3aibIfPyEv9dE/ujnoEwaAX8DMKxp5wzdhMCNsYt2nXxD9i4DqAncXe
	cg92B269VI70c9knt/bZUMCAm3J3MTt9zLgU+TlMTavxmrDjqWTGUoAi2BppZC/mFCzJInIcLJl
	BweKH5qTeh3IFgpBEQ==
X-Google-Smtp-Source: AGHT+IEvJNHFEY70ZCHkTf9bLLQ/xpRNZLwrrnPOmT9ZRkaQAnsvEu15xp7iNKz4p/RtU1qliO8qlA==
X-Received: by 2002:a05:620a:2a08:b0:7c5:5670:bd75 with SMTP id af79cd13be357-7c5ba1e961amr3571891985a.46.1742999643403;
        Wed, 26 Mar 2025 07:34:03 -0700 (PDT)
Received: from ziepe.ca ([99.209.85.25])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b934831esm772669385a.80.2025.03.26.07.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 07:34:02 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1txRpR-000ATd-1m;
	Wed, 26 Mar 2025 11:34:01 -0300
Date: Wed, 26 Mar 2025 11:34:01 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Sumit Garg <sumit.garg@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
	linux-integrity@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [PATCH 2/2] tpm/tpm_ftpm_tee: use send_recv() op
Message-ID: <Z+QQWe/upJuVpU8r@ziepe.ca>
References: <20250320152433.144083-1-sgarzare@redhat.com>
 <20250320152433.144083-3-sgarzare@redhat.com>
 <Z-I86tWMcD6b_YeM@sumit-X1>
 <Z-Pu4FhcntnKii61@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-Pu4FhcntnKii61@kernel.org>

On Wed, Mar 26, 2025 at 02:11:12PM +0200, Jarkko Sakkinen wrote:

> Generally speaking I don't see enough value in complicating
> callback interface. It's better to handle complications in
> the leaves (i.e. dictatorship of majority ;-) ).

That is very much not the way most driver subsystems view the
world. We want to pull logical things into the core code and remove
them from drivers to make the drivers simpler and more robust.

The amount of really dumb driver boiler plate that this series
obviously removes is exactly the sort of stuff we should be fixing by
improving the core code.

The callback interface was never really sanely designed, it was just
built around the idea of pulling the timout processing into the core
code for TIS hardware. It should be revised to properly match these
new HW types that don't have this kind of timeout mechanism.

Jason

