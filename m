Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4492872A1FB
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Jun 2023 20:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjFISSq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Jun 2023 14:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjFISSm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Jun 2023 14:18:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC853586;
        Fri,  9 Jun 2023 11:18:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BF4560EE2;
        Fri,  9 Jun 2023 18:18:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4399CC433EF;
        Fri,  9 Jun 2023 18:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686334720;
        bh=OkmOjAVxbADsnonDXUvbpbOYXcARtzlVbMXpej3Goow=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=VHEpsPG36fQdX2HQ9TT0HQ9jlHnjzogNa/lG/M/U4MsI+8OH1QctOr/lFeVxpv00H
         H3jciWKo96iS5xmSem0O6kK3DoFkad3DOfv/TkT9nJy6t2lxdaCnZlucGLT7x8kX43
         amZotwt2agJT2CpLoo5KlM9Wx/DaMAyIHZPO+BSpNd/7kn0D5ew8j6JNG50t6OIHqm
         VDSbFNl74YwT6PRF1zZY++oGKfuI2VVhgKwiaY8HtlKNHlgrqVVxiTfv0TQNgAKzPy
         uIIsouM91WugRN7xVTMIjD7syzE/iggxPvHdbbogiXfIizohEOprbInhYH+re8OGfr
         o8WrwnGESMgYg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 09 Jun 2023 21:18:32 +0300
Message-Id: <CT8BRJZS8RQU.9ICEA2UAFC7G@suppilovahvero>
Cc:     <kexec@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <nayna@linux.ibm.com>,
        <nasastry@in.ibm.com>, <mpe@ellerman.id.au>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Frank Rowand" <frowand.list@gmail.com>,
        "Mimi Zohar" <zohar@linux.ibm.com>,
        "Nageswara R Sastry" <rnsastry@linux.ibm.com>,
        "Coiby Xu" <coxu@redhat.com>
Subject: Re: [PATCH v9 2/4] tpm: of: Make of-tree specific function commonly
 available
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jerry Snitselaar" <jsnitsel@redhat.com>,
        "Stefan Berger" <stefanb@linux.ibm.com>
X-Mailer: aerc 0.14.0
References: <20230418134409.177485-1-stefanb@linux.ibm.com>
 <20230418134409.177485-3-stefanb@linux.ibm.com>
 <e4dcxwp63uisirxwanjwrhzrnve45wqnxhijfp4oq274r4neco@v2btoy43ue5h>
In-Reply-To: <e4dcxwp63uisirxwanjwrhzrnve45wqnxhijfp4oq274r4neco@v2btoy43ue5h>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu May 25, 2023 at 1:56 AM EEST, Jerry Snitselaar wrote:
> On Tue, Apr 18, 2023 at 09:44:07AM -0400, Stefan Berger wrote:
> > Simplify tpm_read_log_of() by moving reusable parts of the code into
> > an inline function that makes it commonly available so it can be
> > used also for kexec support. Call the new of_tpm_get_sml_parameters()
> > function from the TPM Open Firmware driver.
> >=20
> > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > Cc: Jarkko Sakkinen <jarkko@kernel.org>
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Frank Rowand <frowand.list@gmail.com>
> > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > Tested-by: Nageswara R Sastry <rnsastry@linux.ibm.com>
> > Tested-by: Coiby Xu <coxu@redhat.com>
> > Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> >=20
>
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

If I just pick tpm only patches they won't apply so maybe TPM changes
should be better separated if that is by any means possible.

Open for counter proposals. Just my thoughts...

I.e. I'm mainly wondering why TPM patches depend on IMA patches?

BR, Jarkko

