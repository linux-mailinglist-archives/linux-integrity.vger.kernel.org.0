Return-Path: <linux-integrity+bounces-1537-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC69E86E50B
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Mar 2024 17:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C91EB232BF
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Mar 2024 16:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE1770AE4;
	Fri,  1 Mar 2024 16:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3/Udovg"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A3A6CDB3
	for <linux-integrity@vger.kernel.org>; Fri,  1 Mar 2024 16:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709309447; cv=none; b=mbNLMmPBaxy3n6ewGG0cDfLiWAUXwo4s0GOtXH4FKOzhI0ZRPmRqJAD29p0QLzgBoHyBgErIFqKzWRbI0sJb7uZiKIDE6p9PrEaocKf3nK8UQU5ub4gfdiZ7AEKjj8/X4WZmsZixMEFVxccZw+Xy76dPKInmkEGtj8YKw8K0wLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709309447; c=relaxed/simple;
	bh=B9vtf7Bp+EJoHtAx/ZeqXqVXmrJzUEaI9KqGAyaF1NU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=opyAbnHfdLit2pp7wYWP98xSuRYtN+4jDCwacM95yqgepxMROQmet3KtNIxluBvYzQWxX02SM8wojddk/N0CWPesWRgOfKJ8nwdqeaC/8GypywKo+ocVBOaBBr1+lEK5Nit451hVB2ej061KT+y6slAifPVO0JRJfP9Kn2dG3tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3/Udovg; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-53fa455cd94so1853138a12.2
        for <linux-integrity@vger.kernel.org>; Fri, 01 Mar 2024 08:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709309446; x=1709914246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9vtf7Bp+EJoHtAx/ZeqXqVXmrJzUEaI9KqGAyaF1NU=;
        b=P3/UdovgocVYS5clhKId1cGDCdLAOlDWeeAgI+6UCCpHGxTQEAUqu1W4syKk9cO9CN
         QxKN6qq2zTRtMR0wsAujhqmV8brf2um3D+laDl7ALmmS3tBfmSxTwJKExOoZygvWZWuD
         Wg1PKS5yG9N2gnlfojb/4Hnq3/8Y6iA/lY58qnHAC2hEOY4f+DL4SpLZtW70mzhRc86W
         C2J0ErDhrn0Ic3tCl9ffQIKfbn1C9pFgszcaLpI2gl8NgOqDjDApv+DnOAXUuU5ven6T
         1MJnvmD28EXkUOjG9/NjvI0q2XTKfbqW/EFrBLIUPEAR5U3xxT1t8NAYxyuE+eB2LG1x
         tsQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709309446; x=1709914246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B9vtf7Bp+EJoHtAx/ZeqXqVXmrJzUEaI9KqGAyaF1NU=;
        b=ShAabI6RtJJaxxgSNcCK8j61WaLwMvhkqreg6IJ72XVNK4ksf+/6waqU7++ODr5pfg
         iVtpxKhe0QE5hGSwOWGIs3efmXY+EozGg8s/OkahmPgQTqypjnYx8sZB438XNgMmstS0
         g6xki0OwhtQPQ/79rckpJuXBQe3UC7oagEu7xGz+hUffJUQ1oXhOJaEeYzMfd1RF/BAh
         IMoaXLq5JqHOPCofjX9ziVgVTSCOUwhddAmz4f3kTNO2DT0xmcRcKU3ULnDe3qLSL29B
         TqMza7xnaUHl3uOxO7ywauGPdXP5cNIdhBtZHCCJCNSG3REgVTztkaaQR0+FxD+n2IIE
         2l1g==
X-Gm-Message-State: AOJu0Yy/snJRqst2HOCMY4pmO7zyFvwjS99Md08YvTD+YKqpWx/TYcYQ
	YvQlmSKTnon+uldtdNDOms/IPZncwZkenn8Rz45iAIgcqjKb41K5xsVhMiu5BzHYo02ZOYLTaOE
	fW0Hfq5OfsLPHe0dgqWarzs86USM=
X-Google-Smtp-Source: AGHT+IE6NGB6Z9jXDllkVoyYjl5GvgyV4Bo7FZRTfx/f7CYEFa4yvn+NNCRRhXtLVoNKqy4eOoIF/5ohIE08bab79ec=
X-Received: by 2002:a17:90b:3693:b0:299:2d59:a3d2 with SMTP id
 mj19-20020a17090b369300b002992d59a3d2mr2062245pjb.32.1709309445711; Fri, 01
 Mar 2024 08:10:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9205ed32da8814d8c4d9bde5a03d92c7588f1d9a.1708503094.git.dmitry.kasatkin@gmail.com>
In-Reply-To: <9205ed32da8814d8c4d9bde5a03d92c7588f1d9a.1708503094.git.dmitry.kasatkin@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 1 Mar 2024 11:10:34 -0500
Message-ID: <CAEjxPJ7hVpcqDpDA10QXobJ13EGAkBYREA15B3YQWCzW4Ovenw@mail.gmail.com>
Subject: Re: [ima-evm-utils: PATCH v1 1/1] Change license to LGPL-2.0-or-later
 and GPL-2.0-or-later
To: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: linux-integrity@vger.kernel.org, a.mardegan@omp.ru, git@andred.net, 
	dbaryshkov@gmail.com, ebiggers@google.com, sorenson@redhat.com, 
	gcwilson@linux.ibm.com, James.Bottomley@hansenpartnership.com, 
	kgoldman@us.ibm.com, mjg59@srcf.ucam.org, zohar@linux.ibm.com, 
	patrick.ohly@intel.com, patrick@puiterwijk.org, petr.vorel@gmail.com, 
	roberto.sassu@huawei.com, stefanb@linux.ibm.com, 
	tianjia.zhang@linux.alibaba.com, vt@altlinux.org, vgoyal@redhat.com, 
	z.jasinski@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 3:11=E2=80=AFAM Dmitry Kasatkin
<dmitry.kasatkin@gmail.com> wrote:
>
> Currently libimaevm provided by this project is used by the tool evmctl,
> which is also provided by this project.
>
> An issue was reported about using libimaevm with other software. Its
> GPL2-only license makes it incompatible to use with other licenses, in
> particular GPL3-only.
>
> To address this issue, change the project license to GPL-2.0-or-later
> and libimaevm to LGPL 2.0 or later.
>
> Signed-off-by: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

