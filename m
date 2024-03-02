Return-Path: <linux-integrity+bounces-1542-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C401686F108
	for <lists+linux-integrity@lfdr.de>; Sat,  2 Mar 2024 17:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01BD91C20C84
	for <lists+linux-integrity@lfdr.de>; Sat,  2 Mar 2024 16:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438ED1B5BA;
	Sat,  2 Mar 2024 16:01:32 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF6517578
	for <linux-integrity@vger.kernel.org>; Sat,  2 Mar 2024 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709395292; cv=none; b=BCZ83fTw2f1H/Abv5j010sBC3XfF7hwvPzdoX1vdf38lkYZH7Ryb435vlQvcMnGG6huSXPxveU7gak0EdfhyL5Q9t5muSG0TkuKaOBh2EFuC34IhkEu4kjK7Yn1TcaWNPDAsYFXf+A24+/WMmehPDilF+xnE28xI/RpLWPXssPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709395292; c=relaxed/simple;
	bh=LFiAtGjubDWpNLUQxtbJ/E7SHByKNPAdC4jbSr77kCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sy/jBDQYpgPjeDe1h7I/ElNJJE8rMjvCuLYrJqUiFij3lkf7XDn/T4JBPHIDc8yLpeXY0+X/00MiNC2+DTSRB+ScVxW39oEqkPdrCtuaGavvyyFS8NYCcaqdVajzcj9BA8EUa2gTMRsMzuBzABuntQjTc4ZhMPSzQ5xa4cy5sJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-68f74fb38a8so13028756d6.3
        for <linux-integrity@vger.kernel.org>; Sat, 02 Mar 2024 08:01:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709395288; x=1710000088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XenCVyPUGE/ocH2LizUOZPuh6vZd/WYCNYixpMDiLyI=;
        b=WUMq4dBbyjzG0BdvoYR7weEs4uK/D1Xv+p7SazK6wb/lPn5ag3FvJtakla2paUbDYt
         fKOBdZfAhRvCJtypj27ruZt8I4ud62n8jBnZwT5UQJxBrG6q+ndB9Xu+BfIMGTwhWD/7
         eVGW0/xeJ5tWjt++b18RvVWOwj0Eu9vNGxiRnQ/TVyRKh3ygMzRyNvgUzlG8+8PNtU1Q
         pTngQzeUeY5ESYzaaPV3jxgbiDrPYCjmhbAiQKpYtZrcVnDZssXQJkWPMHebGgadIE96
         FiF1oFeJEtohMEklluBT8DkMbyCZROpfrrXQnQepqFEdu45TkU/y8RAcVmzpv9nIMHSP
         HErA==
X-Forwarded-Encrypted: i=1; AJvYcCV3YdNwzQ6Cw3NB8LHDuVThwiL1AQ0Y36x9b0CVth9mOHAjElWDfzuBFk+hduz5fkmb+E/69c64vwW/rFkWwZJWC6XRFLIK5cwEeOD5iIgJ
X-Gm-Message-State: AOJu0YwAElv3rJrpDCctaSI9Fh6ly2JRa5MRU72doGxYLLUsQHiEZ24W
	DECu/HG4wMxluDPHZOc4AwelbuI+uEeRIWN3YZKSxhld0Fg6SxCnpCKovS/8Zw==
X-Google-Smtp-Source: AGHT+IGzvxitZoqsBYuFgO2HzG9/T+9mfzbc+Y/oQjpPYffJx1lNgpS1DLq5H2YZNnh++/V9NyR/5Q==
X-Received: by 2002:a05:6214:57cc:b0:690:6b94:67fb with SMTP id lw12-20020a05621457cc00b006906b9467fbmr9186qvb.21.1709395288340;
        Sat, 02 Mar 2024 08:01:28 -0800 (PST)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id me19-20020a0562145d1300b0068f85706ecfsm3064940qvb.104.2024.03.02.08.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 08:01:27 -0800 (PST)
Date: Sat, 2 Mar 2024 11:01:25 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Fan Wu <wufan@linux.microsoft.com>
Cc: corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org,
	serge@hallyn.com, tytso@mit.edu, ebiggers@kernel.org,
	axboe@kernel.dk, agk@redhat.com, eparis@redhat.com,
	paul@paul-moore.com, linux-doc@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, audit@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v13 12/20] dm verity: set DM_TARGET_SINGLETON feature
 flag
Message-ID: <ZeNNVWxkhki8lX55@redhat.com>
References: <1709168102-7677-1-git-send-email-wufan@linux.microsoft.com>
 <1709168102-7677-13-git-send-email-wufan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1709168102-7677-13-git-send-email-wufan@linux.microsoft.com>

On Wed, Feb 28 2024 at  7:54P -0500,
Fan Wu <wufan@linux.microsoft.com> wrote:

> The device-mapper has a flag to mark targets as singleton, which is a
> required flag for immutable targets. Without this flag, multiple
> dm-verity targets can be added to a mapped device, which has no
> practical use cases. Also from dm_table_get_immutable_target(),
> it documented that "Immutable target is implicitly a singleton".
> 
> This patch adds the missing flag, restricting only one
> dm-verity target per mapped device.
> 
> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>

FYI, I have picked this one up and staged it in dm-6.9 and linux-next:
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-6.9&id=9356fcfe0ac4a8545f9fc32f2e404524e1115ee6

Mike

