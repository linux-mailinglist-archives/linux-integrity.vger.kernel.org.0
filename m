Return-Path: <linux-integrity+bounces-7927-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25066CB72A1
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Dec 2025 21:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 610C3304809D
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Dec 2025 20:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024F431327A;
	Thu, 11 Dec 2025 20:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="e823m0nw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F59248166
	for <linux-integrity@vger.kernel.org>; Thu, 11 Dec 2025 20:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765484981; cv=none; b=MIG/vikWrmVJs/N4nUkYYLm7Ka8tdF5htV6e/yMWsf8/ZGn1/A5dk0E+wqBN6z2w1vll6VwFgBBYz22neJVyIPODznI2pCvzPj8wFUNJ31xApSdo+B06Plu4rjdHiE+3L1fqK4lachm8btMFPHjxyFwbILCUf6/sYhQvk/KtnB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765484981; c=relaxed/simple;
	bh=9DRRCSLEBB087PyuGppIjlXf6xvxWvNoT6XXU1Vh9Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iDbaInB/F7/krgK+FoKppLYLuSW2xH97UGDO3yUTkcl1eW8sQWyPGOfpax23F1JRoK+P1aoHXlIKVtQPUD154anNWI1RsL1r8iq/d3lbXKfey6Iknh4UHzzA0uh6ReuyL5G7s3M9O2Ng9ajPOAADUkzJQOxqBoukUtiMja+cAMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=e823m0nw; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7c701097a75so287250a34.3
        for <linux-integrity@vger.kernel.org>; Thu, 11 Dec 2025 12:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1765484978; x=1766089778; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9DRRCSLEBB087PyuGppIjlXf6xvxWvNoT6XXU1Vh9Gg=;
        b=e823m0nwJkNkC3jZx7TG7mqG2hoLjbpwHIRBo0iPId9eJEy1W3v1CkVfoAFN/gVn0t
         4ualeUJxefTZ52wS4zDYjcd6iqp445apkpfcx0pQAr9+fhfYM2aAKNMAWq4JQ4o6QGvE
         EgO8pt+6HGTESsG7/xMhPZW/jzGQKSNbXMH2h3Q5iOd4pqNbopg+1FGOahufBpULYDjg
         SmteJ7T0JrCsLC3YR1mpw6GLRkIwGIVDLCn9jo0KXKcXjjrRV+M5u8RbAzhtrtQvm7ey
         U11ngNqucxofrx5gcjAWmzllQ5Ze+B1p+svhdgE5Ijk4blM3ubvPI+NUuo5Pn28Nwo7l
         64qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765484978; x=1766089778;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9DRRCSLEBB087PyuGppIjlXf6xvxWvNoT6XXU1Vh9Gg=;
        b=aK4AWIr9C05gY1H7KOxQ9RElqMf5RLNM1G5rUdenhqLmRjCmzHY2U68OjqNCoElGBa
         at7/wWBKiHwNgRncu6ufHKH0eTm4rLaLWXftC9068qQI5yNPk/imc4ZAsyZ1aBK9u/yo
         54f/wAmiaG5VStnVZ6OWYt7ueRO4eW9/9Ys3FIrIPp8dtgdlDrQoVTMpyyGWm7bXyfev
         nTkjUvSUPaepeI5rKVz+nTGxa3NimeqaugW1PX3PVsVUDYGpQxF1w/1vaioB5h8Zh2Wl
         EzLk//qs0vTwGVqcSSzhB8h8rWBGwjiY29J1w9Tdkf/RHfFnHGUBnsJPi3R2YZgxmmNo
         diSw==
X-Forwarded-Encrypted: i=1; AJvYcCUoSsO/Nr1mR/nQfbzo1ROpH0QVuFjMZNHDVW0oS4qYgvOsHj9Uaf0pwQX02inhLig9LZvAG5xHC9DsqxPKEH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfiNeIjDbvzFJcbhzjeO1BDKgenDnuO3KEnrmMe9rpOIR0v2yC
	doMmhMGxTKcv4Obehvsjt/s4Mobmd/fGV47E25CSGPQmAA1ITEHcmQpqKzZZKNImCJA=
X-Gm-Gg: AY/fxX5COMVOwDk3mPzzD+FhFTHHy7zk3J5C3C4wE8la7jr6Cfy/kWh+w4C98Dr4M6K
	oS9CQcRZPwmDjd6sZvWG+AX3vP8RtoviU9KS6qwCQF2+SH1qWAn0Tgq0/ofUzuNAvRb+YuKGzFu
	y5YK0XMaZaLRfDkIhO3pkWAUjyCX+Yg6W3xa+MoH3+KaieuFFFUAxGS5kDzZoGo/UM5by0NG2kP
	/Z9fYV9iagb38PAY1CGdMppePycLnrA9FjpoYOefG0itQV9Sb53+DSFMDYGqy5zeShCjwGtS1ux
	5nY01XPR2jjgLEueF67ufoStpsNFJrcDSBN594KIdi8q/EcuLkj/sxMgWggU9GV3GwaU3cU8pT/
	x78nQUMTvDZYlje+c+TfhuA107XijhlJesRJ/Q1dYo4O56PSecVV6b6K5wHp7pElwvtU=
X-Google-Smtp-Source: AGHT+IGXgSVW4B5tlWc5GJSs37cpa/Qy9qqjFq/iATd96ugTpEgoseFG1mReqoD0ZC/0hihQZErMHw==
X-Received: by 2002:a05:6820:2019:b0:65b:257b:a898 with SMTP id 006d021491bc7-65b2abebd32mr3716006eaf.29.1765484978148;
        Thu, 11 Dec 2025 12:29:38 -0800 (PST)
Received: from CMGLRV3 ([2a09:bac5:947d:1b37::2b6:8])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65b35f4ec54sm1700561eaf.6.2025.12.11.12.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 12:29:37 -0800 (PST)
Date: Thu, 11 Dec 2025 14:29:35 -0600
From: Frederick Lawler <fred@cloudflare.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>,
	kernel-team@cloudflare.com
Subject: xfs/ima: Regression caching i_version
Message-ID: <aTspr4_h9IU4EyrR@CMGLRV3>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jeff,

While testing 6.18, I think I found a regression with
commit 1cf7e834a6fb ("xfs: switch to multigrain timestamps") since 6.13
where IMA is no longer able to properly cache i_version when we overlay
tmpfs on top of XFS. Each measurement diff check in function
process_measurement() reports that the i_version is
always set to zero for iint->real_inode.version.

The function ima_collect_measurement() is looking to extract the version
from the cookie on next measurement to cache i_version.

I'm unclear from the commit description what the right approach here is:
update in IMA land by checking for time changes, or do
something else such as adding the cookie back.

Thanks,
Fred

