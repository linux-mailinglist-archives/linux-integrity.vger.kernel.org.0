Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B32B6287BB
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Nov 2022 19:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236819AbiKNSCH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Nov 2022 13:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235617AbiKNSBf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Nov 2022 13:01:35 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B9B2B262;
        Mon, 14 Nov 2022 10:00:41 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.5) with ESMTP id 2AEHXTi6007635;
        Mon, 14 Nov 2022 18:00:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : content-transfer-encoding : mime-version; s=pp1;
 bh=QPhSdp/WvfS+gB8RUHumycoy4o2HnncDto2p1MtB9DY=;
 b=OFVyYebNpWw/Lk5Ok4oNlUZyZwd+Yt6FdFX5hhaq1Xtca61+3PE9pUCR+yjD0kHHqE6X
 Aa4Va2Dcmvv3rgrPMCXRtgYflj0A+uwrfaV7j2W1OiVLwhMl06RZ00t8t2rIa6sxiYjd
 1bGFVRJ2wgLglC0gz1MWRED1AEg9PcxyrNL+vZ1FuxYgD9DNRrs/fDOeMYgpy8a2I3GI
 YnikAQjpp57I3vL1Jl9B0MFl38Nf0tlVX7DdovQnG1enSmPqTmxpjYtDv0OepYTlHzjG
 cqeMkFcwrPyMYwXPDwKhIb7MxnoEKR0WYn1fn4pwrsTRCqhP7V4sNCgJLGCF+sS7ae6N Kg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kut698pej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 18:00:17 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AEHXZoB007861;
        Mon, 14 Nov 2022 18:00:16 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kut698pd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 18:00:16 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AEHoaqs019792;
        Mon, 14 Nov 2022 18:00:14 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma04wdc.us.ibm.com with ESMTP id 3kt349f8py-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 18:00:14 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AEI0AkM52101664
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 18:00:10 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54BDE7805E;
        Mon, 14 Nov 2022 18:57:43 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E6D8F7805C;
        Mon, 14 Nov 2022 18:57:39 +0000 (GMT)
Received: from lingrow.int.hansenpartnership.com (unknown [9.211.83.197])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 14 Nov 2022 18:57:39 +0000 (GMT)
Message-ID: <95ffac38780bf0ec6084cb354bfcb3b7bee686b9.camel@linux.ibm.com>
Subject: Re: [PATCH v5 04/11] security: keys: trusted: Include TPM2 creation
 data
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Evan Green <evgreen@chromium.org>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org,
        corbet@lwn.net, linux-integrity@vger.kernel.org,
        gwendal@chromium.org, dianders@chromium.org, apronin@chromium.org,
        Pavel Machek <pavel@ucw.cz>, Ben Boeckel <me@benboeckel.net>,
        rjw@rjwysocki.net, Kees Cook <keescook@chromium.org>,
        dlunev@google.com, zohar@linux.ibm.com,
        Matthew Garrett <mgarrett@aurora.tech>, jarkko@kernel.org,
        linux-pm@vger.kernel.org, David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Mon, 14 Nov 2022 13:00:08 -0500
In-Reply-To: <CAE=gft6L6bMtzbqUfH_NAsFz2r0Nw7kkbCPXcr2nYj5n31FYQg@mail.gmail.com>
References: <20221111231636.3748636-1-evgreen@chromium.org>
         <20221111151451.v5.4.Ieb1215f598bc9df56b0e29e5977eae4fcca25e15@changeid>
         <Y3FfhrgvBNey6T7V@sol.localdomain>
         <ff23b4e24222037959c2a784496c7ee91024e6c5.camel@linux.ibm.com>
         <CAE=gft63-jdKqKmepB+LXPm6WUWSnz+CMWcWWnyN1y-EnS4kVg@mail.gmail.com>
         <c31d1a3af53515f2a9d3f53eb27ce698e796f9b9.camel@linux.ibm.com>
         <CAE=gft6L6bMtzbqUfH_NAsFz2r0Nw7kkbCPXcr2nYj5n31FYQg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mQ0o1bvpk3uvMiLkzZl2cNHEOfjstpwl
X-Proofpoint-GUID: cPzfQg2eCGXV_bQt6IZwGIcCXhV5_zn6
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_13,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 mlxscore=0 mlxlogscore=561
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211140125
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2022-11-14 at 09:43 -0800, Evan Green wrote:
> On Mon, Nov 14, 2022 at 8:56 AM James Bottomley <jejb@linux.ibm.com>
> wrote:
[...]
> > Of course, since openssl_tpm2_engine is the complete reference
> > implementation that means I'll have to add the creation PCRs
> > implementation to it ... unless you'd like to do it?
> 
> I am willing to help as I'm the one making the mess. How does it
> sequence along with your draft submission (before, after,
> simultaneous)?

At the moment, just send patches.  The openssl_tpm2_engine is developed
on a groups.io mailing list:

https://groups.io/g/openssl-tpm2-engine/

You need an IETF specific tool (xml2rfc) to build the rfc from the xml,
but it's available in most distros as python3-xml2rfc.  If you don't
want to learn the IETF XML I can help you code up the patch to add that
to the draft spec.

Regards,

James

