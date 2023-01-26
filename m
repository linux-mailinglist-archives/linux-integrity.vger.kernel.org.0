Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707F467D32F
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jan 2023 18:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjAZRbS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 26 Jan 2023 12:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjAZRbQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Jan 2023 12:31:16 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6229D5D13B
        for <linux-integrity@vger.kernel.org>; Thu, 26 Jan 2023 09:31:14 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-76-f12lco4sMJ-UFDGfrgpghw-1; Thu, 26 Jan 2023 17:31:11 +0000
X-MC-Unique: f12lco4sMJ-UFDGfrgpghw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.45; Thu, 26 Jan
 2023 17:31:09 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.045; Thu, 26 Jan 2023 17:31:09 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Segher Boessenkool' <segher@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
CC:     "gjoyce@linux.ibm.com" <gjoyce@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        "erichte@linux.ibm.com" <erichte@linux.ibm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "nayna@linux.ibm.com" <nayna@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "sudhakar@linux.ibm.com" <sudhakar@linux.ibm.com>,
        "ruscur@russell.cc" <ruscur@russell.cc>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "bgray@linux.ibm.com" <bgray@linux.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "gcwilson@linux.ibm.com" <gcwilson@linux.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH v4 02/24] powerpc/pseries: Fix alignment of PLPKS
 structures and buffers
Thread-Topic: [PATCH v4 02/24] powerpc/pseries: Fix alignment of PLPKS
 structures and buffers
Thread-Index: AQHZMarbHHGSrma/kEeRKp/dNdgk5K6w84Ew
Date:   Thu, 26 Jan 2023 17:31:09 +0000
Message-ID: <5118edd7f1f445afa1812d2b9b62dd4f@AcuMS.aculab.com>
References: <20230120074306.1326298-1-ajd@linux.ibm.com>
 <20230120074306.1326298-3-ajd@linux.ibm.com>
 <87pmb2pxpa.fsf@mpe.ellerman.id.au>
 <20230126171925.GN25951@gate.crashing.org>
In-Reply-To: <20230126171925.GN25951@gate.crashing.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Segher Boessenkool
> Sent: 26 January 2023 17:19
> 
> On Thu, Jan 26, 2023 at 12:09:53AM +1100, Michael Ellerman wrote:
> > Andrew Donnellan <ajd@linux.ibm.com> writes:
> > > A number of structures and buffers passed to PKS hcalls have alignment
> > > requirements, which could on occasion cause problems:
> > >
> > > - Authorisation structures must be 16-byte aligned and must not cross a
> > >   page boundary
> > >
> > > - Label structures must not cross page boundaries
> > >
> > > - Password output buffers must not cross page boundaries
> > >
> > > Round up the allocations of these structures/buffers to the next power of
> > > 2 to make sure this happens.
> >
> > It's not the *next* power of 2, it's the *nearest* power of 2, including
> > the initial value if it's already a power of 2.
> 
> It's not the nearest either, the nearest power of two to 65 is 64.  You
> could say "but, round up" to which I would say "round?"  :-P
> 
> "Adjust the allocation size to be the smallest power of two greater than
> or equal to the given size."
> 
> "Pad to a power of two" in shorthand.  "Padded to a power of two if
> necessary" if you want to emphasise it can be a no-op.

Changing the size to kzalloc() doesn't help.
The alignment depends on the allocator and is only required to have
a relatively small alignment (ARCH_MINALIGN?) regardless of the size.

IIRC one of the allocators adds a small header to every item.
It won't return 16 byte aligned items at all.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

