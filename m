Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1579797D7A
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Sep 2023 22:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239260AbjIGUke (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Sep 2023 16:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbjIGUke (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Sep 2023 16:40:34 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698391BCA
        for <linux-integrity@vger.kernel.org>; Thu,  7 Sep 2023 13:40:29 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-58e6c05f529so13955337b3.3
        for <linux-integrity@vger.kernel.org>; Thu, 07 Sep 2023 13:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694119227; x=1694724027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19mrjjoxcwe4/BUgYp85zEpI/cd8uYB/AjYV4M2OpCk=;
        b=YmACAPOqiIhSXtIRnk6daTl+Z3aJvO0G814ckX18lFnNdjjZVs1TyUbQPgR+oRoxTm
         vypmPALn7zw2g46ghPMC761m0VjNTiJCHLS3O7OBqYnS45e9mnc8JTMLBgmUniPjvT/E
         F15atnfGkmx+/bsHbkGJA/7+jfr56nquN0Ombp3uFxKA7eK3oLCxRNzgsGEZgh1EDZVl
         e5i8ya8XL4jnHGVdY8ZxZSeXKHOvP2/xWJMAVjg3GBYuDBqiHDlIvGW8Qu2U6p6gqyp3
         /vpJur6vyPhupGQPbhZpzaxhR2/jgHjIRm5n3Qfo9uPcSiyjNiporLXc8yjj1ha/m+P3
         CoJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694119227; x=1694724027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=19mrjjoxcwe4/BUgYp85zEpI/cd8uYB/AjYV4M2OpCk=;
        b=PsgPumWl2GQkwjtYXxFYvAAIMq9GeUZw02T93JAW5U2TBfgPVvU5tJTx+jZRSncMyR
         6FKnFrBYepHffV1u0zISSlpz8tNF0xR2KCV6IO45rFHrP3gK8se2MUloN2y+tyoOi9Au
         xsXD91yW7+iFwPtJZURYWx+Ww77WIfhCr/n07gy3fQsrGRJQ3l35I/73uWWJBH6U6vrx
         AUELDdIaOFWmTyoAnrI4hf1kXLYYxiXX8cK6s5eW71vmA7K/d/Ej+MkvdZH5lh62bXDA
         zlWCE5oZarabjeX7W0WBLO/jh+8GZmExbtNdHeZlESpEQmcQxT44BNsJfDGgb2qK8iDP
         4WNw==
X-Gm-Message-State: AOJu0YxrTzCEM1uG0L16uzyrQTeW3N6QggtNKvEnPYDcsUoQ8lWo+xHO
        KcKW2XsF3fn6Dlei+Cj+qIhxGDBdSbw0eHlaetKC
X-Google-Smtp-Source: AGHT+IHwQv9AehS0KpaqBcHRMN5DynaFfcJvsCrwHhe2Bq+Il/WaOenPnY+AGB1mwVw6G5udIdrzbR8b6ETZoEVANjo=
X-Received: by 2002:a0d:db81:0:b0:594:fd81:c3bf with SMTP id
 d123-20020a0ddb81000000b00594fd81c3bfmr709829ywe.1.1694119227671; Thu, 07 Sep
 2023 13:40:27 -0700 (PDT)
MIME-Version: 1.0
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
 <5c323243-e22e-dd61-f808-2875654936a6@linux.ibm.com> <5ce32966-c8c5-adc4-8b9e-f8300b266a61@linux.microsoft.com>
 <696e8be1-ad31-4ffd-711d-6fb5ce54fbd4@linux.ibm.com>
In-Reply-To: <696e8be1-ad31-4ffd-711d-6fb5ce54fbd4@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 7 Sep 2023 16:40:16 -0400
Message-ID: <CAHC9VhTsSKLwnSscgc=HXtBd9N2Ot+3FQCj5SyStFjVDVv-w6w@mail.gmail.com>
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal - network bandwidth
To:     Ken Goldman <kgold@linux.ibm.com>
Cc:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Sush Shringarputale <sushring@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
        jmorris@namei.org, serge@hallyn.com, code@tyhicks.com,
        nramas@linux.microsoft.com, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Sep 6, 2023 at 4:21=E2=80=AFPM Ken Goldman <kgold@linux.ibm.com> wr=
ote:
> On 9/1/2023 5:20 PM, Tushar Sugandhi wrote:
> > On 8/30/23 11:06, Ken Goldman wrote:
> >> On 8/1/2023 3:12 PM, Sush Shringarputale wrote:
> >>> In addition, a large IMA log can add pressure on the network
> >>> bandwidth when
> >>> the attestation client sends it to remote-attestation-service.
> >>
> >> I would not worry too much about network bandwidth.
> > Our bandwidth concerns are about scaled out system.
> >
> > When IMA log size increases in the range of megabytes, and when the
> > number of client devices increases, it makes an impact on the overall
> > network bandwidth.
>
> It should not, because the client only sends new measurements.  It only
> sends the entire list once per boot.
>
> Does a megabyte matter in a modern network? As for overall performance,
> a megabyte may take 10 msec, while the TPM quote could take 1000 msec,
> and verifier hash and asymmetric signature checks are also slower.

I think there are two issues here: the first is the attestation
methodology, the second is simply the size of the deployment.

There is rarely just one answer to a question, and in the case of
remote attestation I believe that holds true.  Sending some delta of
measurements to a remote node performing attestation does reduce the
amount of network traffic, but it does add an additional burden of
state tracking to the attestation node.  Sending the full measurement
log decreases this tracking burden, but it does result in more network
traffic.  Arguably the "best" choice is likely going to be dependent
on a number of complex factors including the size and complexity of
the deployment.

However, the snapshotting work is not about managing network traffic,
it is about mitigating an unbounded memory buffer that has been
causing problems in at least one real world deployment.  The IMA
measurement log snapshot is designed to allow an admin, or some other
privileged entity, to checkpoint the log and trim the old entries in
such a way as to preserve the ability to perform a meaningful
attestation without having to maintain the entire measurement log in a
memory buffer.

--=20
paul-moore.com
