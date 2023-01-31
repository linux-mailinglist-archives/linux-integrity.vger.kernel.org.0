Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADF4682335
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Jan 2023 05:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjAaE0I (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Jan 2023 23:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjAaE0H (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Jan 2023 23:26:07 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C7739B97;
        Mon, 30 Jan 2023 20:26:02 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30V2C3NI007982;
        Tue, 31 Jan 2023 04:25:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=orBpn8DxySwkjINaTjs2Jn1ipDr74tOtJ4EIhV/aEsg=;
 b=qX6+SuYEhwIAI+ZVmnZcnNUotVmVTC/i9aWmRSZY2uFmLxlvYTuQr3pUAtr/JbAWCDcx
 6JLsvVwFcHtWWEjH4rXTrVmCr2jkad6ox4/1HLMm8v63YglenjMG81V+/yAbcnmOp2uK
 WDNTtbqrphpQvp3zjT2mXgNquYU0jaf4CXrJsFvseFXq9LMz5zzcOuhb2tSMed12zY1F
 bAJ+2E+plkwuvtUZHL/nizUWBCOVwkMKQknoKOpEdMcA7yg3HSXwtxId/1lbnmT2VwST
 PU7MQoiAwH8I+QaQ1hRGUfftM1bC10tVOicJeYZiJXCVcICXvAKXKQh5mOM9Y1iTRk83 IQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3neqbtxa9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 04:25:53 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30V4IRaS013659;
        Tue, 31 Jan 2023 04:25:52 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3neqbtxa94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 04:25:52 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30UH1qYe013066;
        Tue, 31 Jan 2023 04:25:50 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3ncvugj4xs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 04:25:50 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30V4PlPA39125490
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 04:25:47 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A34652004D;
        Tue, 31 Jan 2023 04:25:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23B9920040;
        Tue, 31 Jan 2023 04:25:47 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 31 Jan 2023 04:25:47 +0000 (GMT)
Received: from [9.192.255.228] (unknown [9.192.255.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id E09DB60151;
        Tue, 31 Jan 2023 15:25:44 +1100 (AEDT)
Message-ID: <6c9f774e908fe6e50626a1806ea89dccb7f988c5.camel@linux.ibm.com>
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
Date:   Tue, 31 Jan 2023 15:25:44 +1100
In-Reply-To: <9f16d86e855f22823ee24e6a6236a16556425f29.camel@linux.ibm.com>
References: <20230120074306.1326298-1-ajd@linux.ibm.com>
         <20230120074306.1326298-23-ajd@linux.ibm.com>
         <CQ05ZDYG6KNU.1G9O3ITQDIHEM@bobo>
         <9f16d86e855f22823ee24e6a6236a16556425f29.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FIG61fNwqkqkgQXIsyben8QvnxIGk2hx
X-Proofpoint-GUID: VCJ2us_vobJpYELVGML01dVKpuNjUrcZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_01,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=589
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310036
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2023-01-31 at 13:54 +1100, Andrew Donnellan wrote:
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0// The max object size rep=
orted by the hypervisor is
> > > accurate for the
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0// object itself, but we u=
se the first 8 bytes of data on
> > > write as the
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0// signed update flags, so=
 the max size a user can write
> > > is
> > > larger.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*max_size =3D (u64)plpks_g=
et_maxobjectsize() + 8;
> >=20
> > You have this 8 open coded twice (once as sizeof(u64)). You could
> > make
> > it a #define at the top with a brief overview of the hcall format
> > so
> > you
> > don't need so much commentage for it. Although a note here that the
> > objsize does not include the flags bytes is good to keep.
>=20
> Will do.

Thinking about this further, I'm going to change the 8 to sizeof(u64)
to make it clearer that it's linked with the type of the flags
variable, but I am going to keep the other cases as is (they're
sizeof(flags), not sizeof(u64), so it's already obvious how they work,
and I don't want to define a macro for one user).


--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited
