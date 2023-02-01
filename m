Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F07685D44
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Feb 2023 03:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjBACQv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Jan 2023 21:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjBACQu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Jan 2023 21:16:50 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8560D59E72;
        Tue, 31 Jan 2023 18:16:21 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3111oluq023897;
        Wed, 1 Feb 2023 02:15:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Ho+SQWgunhWn2uxNrx0yviUSD97MXJLY5CWAiWZD+4g=;
 b=s3jBH64ZJEouTL3ffF2clt474hmaXpN2uWNlxcc3hVbonOkHKNEowo2o0454fMWGhfWc
 1Hbn4lchCGuXGnZb98o1QPA99Lo7C3Oryt6ZbXb0nks4LkupQ9maKNvaeOLr+Qhkp45O
 se6TraOgAYnrV7TyhHOXyKk7T54QltiIRW8visVBXsrzPxrCHzYujSjrWm9lnbQxy14u
 YDyllh12621bjn0ST7hYB+WE332sItXHzhvEmTMNHKOQwRgUT+6pRWbKIAL3rwatAYJH
 aC8DQzcl5u2zBkg1IVVVE4EzSYd4wEW3x9oSj24/n3Meu5RjTfLl8UC+aB75NR04nt9v Sg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nfescgdty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 02:15:30 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3112FTgV026299;
        Wed, 1 Feb 2023 02:15:29 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nfescgdt5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 02:15:29 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30V82jFu013346;
        Wed, 1 Feb 2023 02:15:27 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3ncvshb05p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 02:15:27 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3112FOPa23593400
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Feb 2023 02:15:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABD0A2004B;
        Wed,  1 Feb 2023 02:15:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B2F320040;
        Wed,  1 Feb 2023 02:15:24 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  1 Feb 2023 02:15:24 +0000 (GMT)
Received: from [10.61.2.128] (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 67AE360425;
        Wed,  1 Feb 2023 13:15:22 +1100 (AEDT)
Message-ID: <1afe8de217d4436b6cdc91d65729c9baacff9274.camel@linux.ibm.com>
Subject: Re: [PATCH v4 22/24] powerpc/pseries: Implement secvars for dynamic
 secure boot
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
        linux-integrity@vger.kernel.org
Cc:     sudhakar@linux.ibm.com, bgray@linux.ibm.com, erichte@linux.ibm.com,
        gregkh@linuxfoundation.org, nayna@linux.ibm.com,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        gjoyce@linux.ibm.com, ruscur@russell.cc, gcwilson@linux.ibm.com,
        joel@jms.id.au
Date:   Wed, 01 Feb 2023 13:15:22 +1100
In-Reply-To: <CQ690JS6Q5RG.8KHL6V7BODI0@bobo>
References: <20230120074306.1326298-1-ajd@linux.ibm.com>
         <20230120074306.1326298-23-ajd@linux.ibm.com>
         <CQ05ZDYG6KNU.1G9O3ITQDIHEM@bobo>
         <9f16d86e855f22823ee24e6a6236a16556425f29.camel@linux.ibm.com>
         <CQ690JS6Q5RG.8KHL6V7BODI0@bobo>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bMAgIRIRLbVC4BxySEJlhsuFJhDg__M-
X-Proofpoint-GUID: HPzhPeOEA4jsEy8uXl5BCn7OebAh-IEW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015 mlxlogscore=935
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302010015
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2023-01-31 at 18:55 +1000, Nicholas Piggin wrote:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0var.datalen =3D 1;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0var.data =3D kzalloc(1, =
GFP_KERNEL);
> > >=20
> > > This could just point to a u8 on stack I think?
> >=20
> > Until we get VMAP_STACK and we'll have to switch back.
>=20
> AFAIKS plpks_read_var does not require linear map, so should not be
> required. IMO that's the right way to go for an external API, so
> actually plpks_write_var is the outlier there and should be changed
> to follow read and remove in not requiring special pointers.

Indeed, I was confused - in the read case, the buffer doesn't get
directly passed to the hcall.

I'll wait a little bit longer for more feedback on v5 of this series
and maybe fix this in v6 if mpe thinks I should respin it again.

--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited
