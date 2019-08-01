Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E84D7E3AD
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Aug 2019 22:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388851AbfHAT64 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Aug 2019 15:58:56 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:37309 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388600AbfHAT64 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Aug 2019 15:58:56 -0400
Received: by mail-io1-f54.google.com with SMTP id q22so27291944iog.4
        for <linux-integrity@vger.kernel.org>; Thu, 01 Aug 2019 12:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0MK7gpkIkb1rDS/a69ip812vylHERRnaq5QfKqF4c5g=;
        b=Wim6L91rkdK7if7zbJVFgaA+tCuQFFtaXs1E5YyqyIQjKTQuffyblAdOQJFXJKd3FC
         cf5pazxaIZtwMeyAaP0z0Z8NBBiOqrSVRdGWQYUXb4MRH6upiV2R8zwf+hBbqpSem/p5
         aDerV0942S4/D+YsPBvXTYqakKrv/5bccKetr96/1veS8UPku22vKUbwMS888IA7qNAJ
         sOcqWNiLEjcIloryyZBxcyXpfrhsRv3g2cJUXmfzx6/i7JhXBRhhWwcBw6c/1FYi6F76
         TED1m6qEMVaJk9zi0qXqsRhyCDqdrX4RDBUyFal4Dyg31pdWfDjNT1N+t+K01xBoiz5o
         VHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0MK7gpkIkb1rDS/a69ip812vylHERRnaq5QfKqF4c5g=;
        b=qWwu+OLBJNWxySCzKeP0sMXm57k0amWYxRYp05AdYSD2AWSPDuKaBfQ4HoLu4n29Lk
         eKHbRYZmT+m3Pf0fTilgcYMOkc+4NTOaLBhdh9YGqyiIgQa2uKoCxZnR5GbpCRyP8pr9
         WSS4m+00rbni5o8UYGbgZTpGBScainuPhadWewAy7YHH6Fmt3wStBKIS1HVPfFQkRq84
         HyTmYFR8E0NmJjQR1UGFTe0O4rOyDMzrBTnCqBWZMOHMgUpU2gn7L3PbBF8EY+d18r6f
         XcMWYUVFBS2zQmGMZF698i2AAkJB5jfOy4fAASlSTc4Fj+5jFZKbARHPTeQ2l5qkHE3P
         5a9A==
X-Gm-Message-State: APjAAAX8RICn9Fm5v/dQ6+z650gh3YRy1HITjIPA+ZQNHFUE2nFVm7pj
        YQzKO4fNyRXJ781eEOjSOCNfvsP2uHhUIWdMEjgHbg==
X-Google-Smtp-Source: APXvYqx2fcMr1CZjkyIaMnvnZ7vLMb0DqQawXYzkaFMTZ2fueXC4V1Uxp10KvoRoAjzp9TZkWeopraFx+nJENQjofPM=
X-Received: by 2002:a6b:f114:: with SMTP id e20mr120992972iog.169.1564689534999;
 Thu, 01 Aug 2019 12:58:54 -0700 (PDT)
MIME-Version: 1.0
References: <1563830080-31069-1-git-send-email-zohar@linux.ibm.com>
 <20190723071545.GA26973@x230> <1563894876.14396.120.camel@linux.ibm.com>
 <20190724072420.GA21901@dell5510> <1563976601.4245.32.camel@linux.ibm.com> <20190801173454.4zjrndyxkn2mokzo@linux.intel.com>
In-Reply-To: <20190801173454.4zjrndyxkn2mokzo@linux.intel.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 1 Aug 2019 12:58:44 -0700
Message-ID: <CACdnJuuL=fHp8uiaUf+Z8Pgaj7pm5J5LmKaFsVpU=_rgj_UDGA@mail.gmail.com>
Subject: Re: Exposing the tpm 2.0 PCRs? (renamed subject)
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Vitaly Chikunov <vt@altlinux.org>,
        "Bruno E . O . Meneguele" <bmeneg@redhat.com>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Aug 1, 2019 at 10:35 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
> What is meant by TPM 2.0 PCRs support?

You can read TPM 1.2 PCR values directly through sysfs. There's no
equivalent mechanism for obtaining the TPM 2 PCR banks - you have to
talk to the TPM yourself.
