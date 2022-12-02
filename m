Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA7B640FC0
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Dec 2022 22:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbiLBVDt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Dec 2022 16:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234190AbiLBVDs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Dec 2022 16:03:48 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B519D80C7;
        Fri,  2 Dec 2022 13:03:46 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B2IWQgL019814;
        Fri, 2 Dec 2022 21:03:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : content-transfer-encoding : mime-version; s=pp1;
 bh=l3YF7d7Osha4HUveR4HvX/7HD6zwUOSpMIQU9u+UtZc=;
 b=mKsYTYr37ehS3zXP91idG9z9wLRV2TKwsxw+gihdb1OPxKe+XPlnNw7v5XAfYEhooHRe
 GmhgyRbM/DI7FJ5hYIHntmf/w8yiQzYcDUu7HzmWjcc2raGT9TzSAWBakrXa8lEU6RVx
 rYah4wRfh5P3FDQMoflcMWA3djz0EtK5qg4SIdlr8i/yi6Iu1bFGQ0N5/ZUYM+bQ0uLE
 XEQ+UCVLwXkY99bsY2UeuX8Ei6VLHQrZfFmF84zs1t/u+5RSHYLKaK1Dkuy7+tFoNTlS
 ySF35F8ot6BOPyLY2dRHod/zByDtiOo6MNL1hpTD/PUqzy3l5PPAJD7Egs5wUxhSFsrW iw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3m7pqwtuam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Dec 2022 21:03:17 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2B2Krx5O004621;
        Fri, 2 Dec 2022 21:03:16 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3m7pqwtua6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Dec 2022 21:03:16 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2B2Kp5MW009983;
        Fri, 2 Dec 2022 21:03:15 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma02wdc.us.ibm.com with ESMTP id 3m3aeam324-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Dec 2022 21:03:15 +0000
Received: from b03ledav004.gho.boulder.ibm.com ([9.17.130.235])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2B2L3EuJ34931234
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Dec 2022 21:03:14 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D5B67805E;
        Fri,  2 Dec 2022 22:13:21 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42E997805C;
        Fri,  2 Dec 2022 22:13:18 +0000 (GMT)
Received: from lingrow.int.hansenpartnership.com (unknown [9.211.83.181])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  2 Dec 2022 22:13:17 +0000 (GMT)
Message-ID: <6f66f174af92a9b23bddd72945e94e888b0c9420.camel@linux.ibm.com>
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
Date:   Fri, 02 Dec 2022 16:03:09 -0500
In-Reply-To: <95ffac38780bf0ec6084cb354bfcb3b7bee686b9.camel@linux.ibm.com>
References: <20221111231636.3748636-1-evgreen@chromium.org>
         <20221111151451.v5.4.Ieb1215f598bc9df56b0e29e5977eae4fcca25e15@changeid>
         <Y3FfhrgvBNey6T7V@sol.localdomain>
         <ff23b4e24222037959c2a784496c7ee91024e6c5.camel@linux.ibm.com>
         <CAE=gft63-jdKqKmepB+LXPm6WUWSnz+CMWcWWnyN1y-EnS4kVg@mail.gmail.com>
         <c31d1a3af53515f2a9d3f53eb27ce698e796f9b9.camel@linux.ibm.com>
         <CAE=gft6L6bMtzbqUfH_NAsFz2r0Nw7kkbCPXcr2nYj5n31FYQg@mail.gmail.com>
         <95ffac38780bf0ec6084cb354bfcb3b7bee686b9.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zHzyh_mb8TepzfPQ11qtRN52QY2r-J1v
X-Proofpoint-ORIG-GUID: sPQup2CTJfvDp6URQ1pmFgRxtBqWs-WP
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-02_12,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxlogscore=371 spamscore=0 phishscore=0 clxscore=1011 lowpriorityscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212020169
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2022-11-14 at 13:00 -0500, James Bottomley wrote:
> On Mon, 2022-11-14 at 09:43 -0800, Evan Green wrote:
> > On Mon, Nov 14, 2022 at 8:56 AM James Bottomley
> > <jejb@linux.ibm.com>
> > wrote:
> [...]
> > > Of course, since openssl_tpm2_engine is the complete reference
> > > implementation that means I'll have to add the creation PCRs
> > > implementation to it ... unless you'd like to do it?
> > 
> > I am willing to help as I'm the one making the mess. How does it
> > sequence along with your draft submission (before, after,
> > simultaneous)?
> 
> At the moment, just send patches.  The openssl_tpm2_engine is
> developed on a groups.io mailing list:
> 
> https://groups.io/g/openssl-tpm2-engine/
> 
> You need an IETF specific tool (xml2rfc) to build the rfc from the
> xml, but it's available in most distros as python3-xml2rfc.  If you
> don't want to learn the IETF XML I can help you code up the patch to
> add that to the draft spec.

Just as a heads up, the patch series implementing signed policy (and
thus taking option [3]) is on the mailing list for review:

https://groups.io/g/openssl-tpm2-engine/message/296

With apologies for the awful lack of threading in the groups.io
interface.

So you don't have to build the RFC yourself, I published the proposed
update on my website:

https://www.hansenpartnership.com/draft-bottomley-tpm2-keys.html
https://www.hansenpartnership.com/draft-bottomley-tpm2-keys.txt

If you want to use option [4] for the creation data, it's available.

Regards,

James


