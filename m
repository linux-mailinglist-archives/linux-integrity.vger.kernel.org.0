Return-Path: <linux-integrity+bounces-3921-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C46119B2B0E
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Oct 2024 10:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD268B22017
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Oct 2024 09:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E17A192D61;
	Mon, 28 Oct 2024 09:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JHxrPkWw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EBB198A29
	for <linux-integrity@vger.kernel.org>; Mon, 28 Oct 2024 09:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730106577; cv=none; b=qOLJCbr7wrmdMNxBOjmRgD3+3hOJ8kF3RitsTZma19uJs9BiDLU5xjjXAnBqX/TZVy4hC0mOqyp/QQmDmNtaMRl255svqN4EYXT7qH2+1cwUhiKUu7hfNldFsrfvWpuvBdzomlfOiX6YhKmMIjVAoeVUntDYW66aCzVhGO26z6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730106577; c=relaxed/simple;
	bh=kGJMo94pztTrQ+vrO/3L61iWAQ2hdMgd7tvcHrFGYZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kjHlUIWNWX37PX3K0yRMLzGHrp88y48RzZ7aP3IrbFE67yN1Y6pq6e1Isf2fbiojKOxGFY0JdGpTPpa/Ns2w5bOIKdWZhPSgG0YHIkS46SkVuGV3mXr2CMlM2ciQz6y6cAfttsJ2LfXS+oRCQl5HkHH5yIn4pF1DC8uRrUpYJrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JHxrPkWw; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4315e62afe0so42828835e9.1
        for <linux-integrity@vger.kernel.org>; Mon, 28 Oct 2024 02:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730106572; x=1730711372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGJMo94pztTrQ+vrO/3L61iWAQ2hdMgd7tvcHrFGYZs=;
        b=JHxrPkWw5LdVduWj3noaet4XJBArmq8tHIgldi4wVU9YgxGZd/UcwJIVHFZPnHYJOz
         gESpPY7gncFxqfntUcab1alMg2DIOmVzlbh9JmSbzO6mpMJ7xWPTykjMrnDoIY+uMyWG
         4kp42HRaImZXXs1Xk11jYo1mWiv/LJWzBNqoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730106572; x=1730711372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGJMo94pztTrQ+vrO/3L61iWAQ2hdMgd7tvcHrFGYZs=;
        b=g/V2l8woYEKmHNP/WimgwvjgQN9a1WBZhhE2liq6SNhbLDGLx8U2tuWhXpE/YppJxJ
         DO71WdhzD6igAWsNY3VvK0UwJMpUwBjoKKeUk9TEn8vWGvgIZXPuHQ1yr/T42QmURZl9
         txw5bsGmy+4fpbsSuCEXWy7rMrDLqfaDI25i8/TgkPaqD+37aqGCj3HxraKa6Yc+5yCm
         nPw1x9AxixqcJyx2NfEHQ0LGCE+hRKXatG7kfYnJrEufTCcVnoj1lU23r0wGbM6w5OMg
         isKD7IDWTFZ/pgV3RxGRaLzbqHmba/7KzZ2+pJOcgu/omBxvGfiN0EVLKyjEIk2/9M21
         HieQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4y9t9oPEp1UZ+e2gd7cTzvzBleEC4C6Iiy1S9Cy/2N9+fKPty+fZLHGw3VRt3+TX+kzZ1gApEbq8OfRQ//uE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK8mhPJ7pNRJEpB6hi7WKjUBdGRJNbgUgRZ3aHE2W+e5h6DTrW
	VVlhj4EylvG07Lo6LeqJbAdk2RxNKp1GchRfXrLk7PVXpkiOYEdaYYAcq+p9Lg==
X-Google-Smtp-Source: AGHT+IHupxA1uryAe1xJQhJkjl+klF7yUGAE5ih1MF1czh5phkCRatySCzSxPhaduLKL4NK3TFuFjg==
X-Received: by 2002:a05:600c:548a:b0:42c:c003:edd1 with SMTP id 5b1f17b1804b1-4319ac9c555mr68141075e9.10.1730106572421;
        Mon, 28 Oct 2024 02:09:32 -0700 (PDT)
Received: from localhost (105.93.155.104.bc.googleusercontent.com. [104.155.93.105])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4319359527asm102221255e9.16.2024.10.28.02.09.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 02:09:31 -0700 (PDT)
From: Grzegorz Bernacki <bernacki@chromium.org>
X-Google-Original-From: Grzegorz Bernacki <bernacki@google.com>
To: jsd@semihalf.com,
	jarkko@kernel.org,
	bernacki@chromium.org
Cc: apronin@google.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	mw@semihalf.com,
	peterhuewe@gmx.de,
	rrangel@chromium.org,
	timvp@google.com
Subject: Re: [PATCH V3 0/2]  char: tpm: Adjust cr50_i2c locking mechanism
Date: Mon, 28 Oct 2024 09:09:30 +0000
Message-ID: <20241028090930.2179983-1-bernacki@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
In-Reply-To: <20241010091559.30866-1-bernacki@google.com>
References: <20241010091559.30866-1-bernacki@google.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jarkko,

Could you check if there is any additional work needed for these patches?
Please let me if you have any more comments, which can block it from being
merged.

thanks,
greg


