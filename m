Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B52C4776B
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Jun 2019 01:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfFPX4L (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 16 Jun 2019 19:56:11 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38359 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfFPX4L (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 16 Jun 2019 19:56:11 -0400
Received: by mail-pg1-f193.google.com with SMTP id v11so4721583pgl.5
        for <linux-integrity@vger.kernel.org>; Sun, 16 Jun 2019 16:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version:content-transfer-encoding;
        bh=eKbpzEiJylVko/AqUmYGdm35tR1kAF8kyTrOQOn/LZY=;
        b=mjFgfEh9DpnUyYJnmm10xCAA44rjQ5vM3POmL21L1yxtntOM4gCLmgenR1CUMVLdRK
         bKJ5vWJRNlNGEcrq4IdxzCEHcpIe7vlLMfhuxhzjrr57rEblFOm2QshpZwxJlJUsK8FS
         r9C0ItB6L+JRovFIxzCuNpKzuioK88/Kll0kA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=eKbpzEiJylVko/AqUmYGdm35tR1kAF8kyTrOQOn/LZY=;
        b=SCuYAiYgVu0i12JHn4TSXowWVkGhzryR7NeyPtbGs9Bf3nLbAAm7SNJG9iL//1eRs2
         ytYCEnxgH+V0iBh/D4UrBaZE2yAJdQP5Sk7VNAo1n6/t8+GUgiG4Wmdr6mE+XlHa24pl
         sxyNHN7odB+9ldehFoBMlNLpfCNxBJhjw+Lmcc6Szlklk/BaUDK6TFVStpK2GMsiL/LN
         Aelx8XonyJUBqP4v4lteq+As2f1HxsjeVDL++7HoV5LcEGDMq/v+zp9WcBAM2APPG/VY
         v9/FGrBdJhO9M6eDjchlw0NlAyam89M3nnHMw6Xe1Y0ePadjP+EqlYCrqInMVUmeDWmO
         WBQQ==
X-Gm-Message-State: APjAAAVthfgdJWhonkXP9kRJCs6bK8Nt8jm6gE19w5x7dM+aTmzZDkNT
        qaLP0/lJmI5kCUvS4sUy+P9W4w==
X-Google-Smtp-Source: APXvYqzVFXwvbw+h8Vy5oNuVgOROK+vJF9NO7ccBNAEWTkL02XdJ05Npe6ZqjRHegh2kVzPtwd85kA==
X-Received: by 2002:a63:6981:: with SMTP id e123mr22346754pgc.136.1560729370570;
        Sun, 16 Jun 2019 16:56:10 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id v4sm9131345pfb.14.2019.06.16.16.56.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 16 Jun 2019 16:56:09 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Nayna <nayna@linux.vnet.ibm.com>
Cc:     Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Eric Richter <erichte@linux.ibm.com>
Subject: Re: [PATCH v3 1/3] powerpc/powernv: Add OPAL API interface to get secureboot state
In-Reply-To: <b2cedb05-6373-b357-f35c-bc112c78a6fc@linux.vnet.ibm.com>
References: <1560198837-18857-1-git-send-email-nayna@linux.ibm.com> <1560198837-18857-2-git-send-email-nayna@linux.ibm.com> <87ftofpbth.fsf@dja-thinkpad.axtens.net> <eaa37bd0-a77d-d70a-feb5-c0e73ce231bf@linux.vnet.ibm.com> <87d0jipfr9.fsf@dja-thinkpad.axtens.net> <b2cedb05-6373-b357-f35c-bc112c78a6fc@linux.vnet.ibm.com>
Date:   Mon, 17 Jun 2019 09:56:05 +1000
Message-ID: <87tvcp2iga.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Nayna,

>> I guess I also somewhat object to calling it a 'backend' if we're using
>> it as a version scheme. I think the skiboot storage backends are true
>> backends - they provide different implementations of the same
>> functionality with the same API, but this seems like you're using it to
>> indicate different functionality. It seems like we're using it as if it
>> were called OPAL_SECVAR_VERSION.
>
> We are changing how we are exposing the version to the kernel. The=20
> version will be exposed as device-tree entry rather than a OPAL runtime=20
> service. We are not tied to the name "backend", we can switch to calling=
=20
> it as "scheme" unless there is a better name.

This sounds like a good approach to me.

Kind regards,
Daniel

>
> Thanks & Regards,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Nayna
