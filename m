Return-Path: <linux-integrity+bounces-4265-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0B29DF85B
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Dec 2024 02:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 343AC161717
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Dec 2024 01:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2D510A3E;
	Mon,  2 Dec 2024 01:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XBhUUEcj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF8A134AB
	for <linux-integrity@vger.kernel.org>; Mon,  2 Dec 2024 01:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733102208; cv=none; b=sUiyPqK8j9xdI7YYa+NZf/wuvpyhiiNRModcsk1tmjcnl86h8sQXT5+sYwVypk1fyl33XHwdVXsTPsKrP9CHqAGl10ITKvXrY3sUuhDmUOKnBEBKprH9z21GyOn9i+i7GJbNmT25I0G7nEMJkBNAtQSpd6ISKqbdeEGkhID6wDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733102208; c=relaxed/simple;
	bh=/UrGsOVqIY1Gt6FFFdeG/9gaPv1Xohtpvjj9Shw/pkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aa+pp96WHI6HM4lVh0atA+4z7TKhHR2r0rqe4MEkf9ygm9vUKJKIHjxKEOEyHzIefMH8jGz0FhMbGSjNa5IuOeel1xOkV2h2h2jwi0Zsjx4ngD25K8kKRppRu5kpeaKqr0omQxnAbioUjL38V9xltBqCnORufBEGy0et+K7kliw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XBhUUEcj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733102205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8/6MnNg5l3sSP+EaErq6fiK52g1SIbAbRkJqLczW120=;
	b=XBhUUEcjLEYTShOiqCjBDmn6zhaXp7v8vve1x8xXeRjY7twGC8knGBUFrdisvqsRT/unOl
	pIXyev9xtJoq+OJyvVnaPgLBREYry4XchaG8LTohPemIcwy6OCk5ClzUzQSRjPZPKg30fU
	TDDPAA+w5rDQ9tvp1Szml5mRWwe3AHc=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-vQYgSqi5P-2V70YFfGL94A-1; Sun, 01 Dec 2024 20:16:43 -0500
X-MC-Unique: vQYgSqi5P-2V70YFfGL94A-1
X-Mimecast-MFC-AGG-ID: vQYgSqi5P-2V70YFfGL94A
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-215699398bdso9259695ad.0
        for <linux-integrity@vger.kernel.org>; Sun, 01 Dec 2024 17:16:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733102202; x=1733707002;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8/6MnNg5l3sSP+EaErq6fiK52g1SIbAbRkJqLczW120=;
        b=foB4modXQt/1PMuaQ8quudrFYzBEOE6KiMKmIr5rFJcQIO39NoXwxRoGHKt1RjHJBI
         P2IVD10bWhh/rp/6J4uQkv58NNOYHI9lJt2T2WRwJ+CWfEmfRty1gudU5IgjUgyROW+g
         fFXN3dsfG8S2Zdf8/ErSFtmsB6vyHwa4+lhLiEAtse9gI5gJItr7OsD/pcfMNNVLKkFm
         N3IKjgvcgVn6jI3VQ0mr4gnHo9hBkby7IfDXVAYs/M8sYq5BwpniYwqMMZP91kv6z4jP
         lhzx9R/laubfnrbCEetCsaoeM4OdKKgbZc/W/b78DmbiRf87X6b7LFofUviTBOA6p1rp
         bUeQ==
X-Gm-Message-State: AOJu0Yzx+Zw335o2JeoqTh0GC/U4MK38wBA2o0BVTvYesiFcL39tpG84
	HEP982yp/tpVn+gN+LbTWyWwK+RUR7E4CiJeln1mXMoptJVYZFy0vycBjTvnQ9eGiGxTdbAvfpR
	MYCcZMD0+Sj01heToTjCO1uOeo5MiO8FraEpqc+M86Skki9j2aQ0zxbghd1KAyT9sjg==
X-Gm-Gg: ASbGncvU+khbQT2/SsqZFciYaLmLsTT4RDdDguhVnlMjsPflZ5GiIMelD0PdQpLPCeQ
	yErpW/IIFtJGGa5bOoUZRcUp+Eh7qXjbHPsR58KEhlrdhBTlnqUpxBpho2zJwpIixNHS/Hmvphj
	m1VhhzN7rCOPUB6um+itBz0qZa2dBeKWO4Ojq0B9oBHkEy7NhX3FskM7dq2iXKqSA4ebUHq3nzT
	ryMW8tcoMS6dqkt0LbEaLnRxkbkR8ghUwz7ZSXbPvP3LH5M3Fk=
X-Received: by 2002:a17:902:ce05:b0:215:9ea1:e95e with SMTP id d9443c01a7336-2159ea1f165mr10346535ad.13.1733102202327;
        Sun, 01 Dec 2024 17:16:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdo1IRK4QsahuSkUap52DApEedDEzSlALQzgg+guZJqRNIEVNXJK75esVMQ+fkKQEkeL4deA==
X-Received: by 2002:a17:902:ce05:b0:215:9ea1:e95e with SMTP id d9443c01a7336-2159ea1f165mr10346265ad.13.1733102202025;
        Sun, 01 Dec 2024 17:16:42 -0800 (PST)
Received: from [10.72.112.98] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21566738ea7sm27004195ad.31.2024.12.01.17.16.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Dec 2024 17:16:41 -0800 (PST)
Message-ID: <bd3640a6-c2ac-4ede-a00e-a92e7c7910d1@redhat.com>
Date: Mon, 2 Dec 2024 09:16:31 +0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] doc: correct the build steps for open_posix_testsuite
To: ltp@lists.linux.it
Cc: linux-integrity@vger.kernel.org, chrubis@suse.cz
References: <20241202010012.1266775-1-xiubli@redhat.com>
Content-Language: en-US
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20241202010012.1266775-1-xiubli@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Please ignore this.

Thanks.

On 12/2/24 09:00, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
>
> './configure' is needed just before generating the Makefiles.
>
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
>
> V2:
> - a minor fixing about the order, thanks Cyril.
>
>   doc/users/quick_start.rst | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/doc/users/quick_start.rst b/doc/users/quick_start.rst
> index 1581b1f0c..598a95e2a 100644
> --- a/doc/users/quick_start.rst
> +++ b/doc/users/quick_start.rst
> @@ -53,6 +53,7 @@ generated first:
>   
>   .. code-block:: console
>   
> +   $ ./configure
>      $ cd testcases/open_posix_testsuite/
>      $ make generate-makefiles
>      $ cd conformance/interfaces/foo


