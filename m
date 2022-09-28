Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431A15EDA27
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Sep 2022 12:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbiI1KfO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Sep 2022 06:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbiI1Ke6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Sep 2022 06:34:58 -0400
X-Greylist: delayed 1801 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 28 Sep 2022 03:34:54 PDT
Received: from the.earth.li (the.earth.li [IPv6:2a00:1098:86:4d:c0ff:ee:15:900d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0701527B09;
        Wed, 28 Sep 2022 03:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
        s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=K8E0FzdNDrn2vBMjfp3h2KajM+B36hLnkhE+pnW7Lb8=; b=tCA2PesD4/l8yPuyvQFPWi3nUi
        WDiKR+zssEkSliDYZ2hVjvPR+Szf1TApxTmnbwAMxTf915JhbObbstSRCUc3Lic1QeEwgzYvP6EUh
        E+HrV3DixfeX4F/TNF1TquUoGGA7VNn4gpom38VrTloH1m/goBh/WB+YNyX0rzeKf4R7ZOmEuRTQq
        lxlpOgRJ9U+4WI4L3QATPubbUcrIrhQwb8gpqlPOzRG+HOU3PdSCpGjYJYaw9s2blFvl7wHvDk+oK
        d2JJV692QJh++TV62L7H/y3y9vcbNIISAmJth+4tutxt0bYuboCfAsbkpf0eT1Ca0q8XXzh87UJ/D
        yV6o44QQ==;
Received: from noodles by the.earth.li with local (Exim 4.94.2)
        (envelope-from <noodles@earth.li>)
        id 1odTaO-00Gcuf-D2; Wed, 28 Sep 2022 10:42:36 +0100
Date:   Wed, 28 Sep 2022 10:42:36 +0100
From:   Jonathan McDowell <noodles@earth.li>
To:     Evan Green <evgreen@chromium.org>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Matthew Garrett <mgarrett@aurora.tech>,
        Ken Goldman <kgold@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniil Lunev <dlunev@google.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: TPM: hibernate with IMA PCR 10
Message-ID: <YzQXDPtDisogYNzo@earth.li>
References: <CAHSSk06+CNQLKS8p_jh8JH7acn6=Ck8W3W2DM75rV3paZQ+MbA@mail.gmail.com>
 <Yw7L+X2cHf9qprxl@kernel.org>
 <CAE=gft68it0VtFfddCiSQYfz2+Fmoc+6ZK-ounDrjuRJ8nsOLw@mail.gmail.com>
 <96360ec16b21d8b37461a5de083ff794f3604300.camel@linux.ibm.com>
 <Yxl8tbJERqrmsgpU@kernel.org>
 <96cfd1f3f084f6d145bd22e0989dc046fe15b66a.camel@linux.ibm.com>
 <YylDYU+KTX/KJpqU@kernel.org>
 <2bc656bf67af52e0b9a68e91c5b574e0ab4ffa8e.camel@linux.ibm.com>
 <Yy21B4EGumiI9XsU@kernel.org>
 <CAE=gft7CnUVPqKpCHKPSpa3z-NR9pimhUJbz+qTkVV0E6WeoPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE=gft7CnUVPqKpCHKPSpa3z-NR9pimhUJbz+qTkVV0E6WeoPw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Sep 27, 2022 at 09:03:21AM -0700, Evan Green wrote:
> On Fri, Sep 23, 2022 at 6:30 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > On Wed, Sep 21, 2022 at 04:15:20PM -0400, Mimi Zohar wrote:
> >
> > > Enabling hibernate or IMA shouldn't be an either-or decision, if at all
> > > possible.  The main concern is that attestation servers be able to
> > > detect hibernation and possibly the loss of measurement
> > > history.  Luckily, although the PCRs are reset, the TPM
> > > pcrUpdateCounter is not.
> > >
> > > I would appreciate including a "hibernate" marker, similar to the
> > > "boot_aggregate".
> >
> > Yeah, I guess that would not do harm.
> 
> I think I understand it. It's pretty much exactly a boot_aggregate
> marker that we want, correct?
> 
> Should it have its own name, or is it sufficient to simply infer that
> a boot_aggregate marker that isn't the first item in the list must
> come from hibernate resume?

I think it should have its own name, because a subsequent boot_aggregate
is inserted when we kexec into a new kernel.


J.

-- 
"Why? - because it's f***ing there!" -- Edmund Hilary
This .sig brought to you by the letter I and the number 30
Product of the Republic of HuggieTag
