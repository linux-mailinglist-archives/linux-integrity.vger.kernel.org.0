Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B01693796
	for <lists+linux-integrity@lfdr.de>; Sun, 12 Feb 2023 14:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjBLNdo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 12 Feb 2023 08:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjBLNdn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 12 Feb 2023 08:33:43 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7EF11168;
        Sun, 12 Feb 2023 05:33:42 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31CArhrW011314;
        Sun, 12 Feb 2023 13:33:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=dOicgCe8+QU2ZEzdLzCwvOTevgtQeHSjrevOEYF4M7I=;
 b=BQT8tNQHiQh7495r61xeWGe+eGEnns89WGup7FlFUiAIf7bw7YdYrcCprEmlsnFTrmII
 6jyVtrSDSehXpq4tIZ1fa4DHOv3tHYsLAcNJNDiaUT8fXAgQh3oczkQ3QsrU56tWnN9D
 KL/uLp6PGeZz+AiyGKpjDCbSFm7BoLLBqN4+Tbd5arTcfQOwk+rGIug4AYNMQvHTfPjj
 nyZqvOo2LnJPbYFLpk73mS3IPEvmzHUYLziiGa9ZUNJUhA8CeLA0UJ2p5ItZwXZQZl31
 Genq2RGevgcNPbw5BGNlRYXPhq4liKViIvAApcBv0/pPc/gcXz2q5c/lS59AT7l46VvL LQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3npxrvt002-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 12 Feb 2023 13:33:31 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31CDU7Fm026459;
        Sun, 12 Feb 2023 13:33:31 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3npxrvsyyr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 12 Feb 2023 13:33:30 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31BMbRTj031193;
        Sun, 12 Feb 2023 13:33:29 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3np29fhjyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 12 Feb 2023 13:33:29 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31CDXQAU47251824
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Feb 2023 13:33:26 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD2E520043;
        Sun, 12 Feb 2023 13:33:26 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3995E20040;
        Sun, 12 Feb 2023 13:33:26 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sun, 12 Feb 2023 13:33:26 +0000 (GMT)
Received: from [9.43.187.72] (unknown [9.43.187.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id BC30C600BA;
        Mon, 13 Feb 2023 00:33:19 +1100 (AEDT)
Message-ID: <b928627ce5a2d90b0ad33d89ce48ec19a2655111.camel@linux.ibm.com>
Subject: Re: [PATCH v6 24/26] powerpc/pseries: Implement secvars for dynamic
 secure boot
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     sudhakar@linux.ibm.com, erichte@linux.ibm.com,
        gregkh@linuxfoundation.org, nayna@linux.ibm.com, npiggin@gmail.com,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        gjoyce@linux.ibm.com, ruscur@russell.cc, joel@jms.id.au,
        bgray@linux.ibm.com, brking@linux.ibm.com, gcwilson@linux.ibm.com
Date:   Mon, 13 Feb 2023 00:33:17 +1100
In-Reply-To: <a63276d5-1be4-b140-6a4a-4ad4efa60eda@linux.ibm.com>
References: <20230210080401.345462-1-ajd@linux.ibm.com>
         <20230210080401.345462-25-ajd@linux.ibm.com>
         <f35e9ba1-5fdb-4cfa-5b41-cc55307dcd45@linux.ibm.com>
         <a63276d5-1be4-b140-6a4a-4ad4efa60eda@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Hg5HAqHdQ43knZIZDzwbGuGMkbEZx_Lr
X-Proofpoint-GUID: -tzNATl1h47RB1-2K7Zd9Qbc9SLl6_Ai
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-12_02,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 spamscore=0 impostorscore=0 adultscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=901 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302120115
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2023-02-10 at 16:28 -0500, Stefan Berger wrote:
> > > +err:
> > > +=C2=A0=C2=A0=C2=A0 kfree(var.data);
> >=20
> > remove the kfree()
>=20
> Actually don't remove it but it should probably be
>=20
> if (var.data !=3D &version)
> =C2=A0=C2=A0=C2=A0=C2=A0 kfree(var.data);
>=20

Argh, thanks for catching this.

I don't think the condition is needed - we can assume the var.data is
unmodified.

mpe, are you able to fix this up in merge?

--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited
