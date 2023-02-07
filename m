Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F7868CEDF
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Feb 2023 06:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjBGF0C (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Feb 2023 00:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjBGFZ7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Feb 2023 00:25:59 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174D323337;
        Mon,  6 Feb 2023 21:25:55 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3173RcDC031589;
        Tue, 7 Feb 2023 05:25:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=MDDY2xtAagBPSEC6o2U7J4JQZ3D1QDD9r7/0FqNQWgE=;
 b=bnVp5EiJvF8XQTF7p6NDpZ8zdthL6lGbH3IZVQTjJqQG8kXhRDOr34/7yYbOPc3X8g3/
 SVMjyiFG6TNWbCApCuzAfzZEdBW8XK0c4L/dAoCqVB8jekx+j+D9Q41AKfT9zT8WYcda
 N6xeXOCz+TQTMJeFzWHycC+D74LJrfvnh98KwO/Ec33XqqzlcHDkEjJUUOwHS7yy6fcE
 RL2Q6n17/tJ8vBXkxAHsAy/7vdPy8YVGkZvfGgLxOV2ayrJDJbQWur3kedLyZm1JGRPx
 vDpVe97+8D9ON/VTZGxqNcRf6C/5pggzOSbj0NPaFarbF5VCLlpMy2a2aSFk5O8bSUwB wA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nkda0v1s4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 05:25:44 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31751726028763;
        Tue, 7 Feb 2023 05:25:44 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nkda0v1rf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 05:25:44 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 316HgKLO023711;
        Tue, 7 Feb 2023 05:25:42 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3nhf06u5ja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 05:25:42 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3175Pd5R25100566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Feb 2023 05:25:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CDB0020049;
        Tue,  7 Feb 2023 05:25:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48BC620040;
        Tue,  7 Feb 2023 05:25:39 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  7 Feb 2023 05:25:39 +0000 (GMT)
Received: from [10.61.2.128] (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 6925A6010B;
        Tue,  7 Feb 2023 16:25:35 +1100 (AEDT)
Message-ID: <1be52a01d4d467300b9197f384498174a6942c10.camel@linux.ibm.com>
Subject: Re: [PATCH v5 19/25] powerpc/pseries: Make caller pass buffer to
 plpks_read_var()
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     ruscur@russell.cc, bgray@linux.ibm.com, nayna@linux.ibm.com,
        gcwilson@linux.ibm.com, gjoyce@linux.ibm.com, brking@linux.ibm.com,
        sudhakar@linux.ibm.com, erichte@linux.ibm.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        zohar@linux.ibm.com, joel@jms.id.au, npiggin@gmail.com,
        Michael Ellerman <mpe@ellerman.id.au>
Date:   Tue, 07 Feb 2023 16:25:35 +1100
In-Reply-To: <5c335c29-ecb6-70eb-ab8e-caadde774434@linux.ibm.com>
References: <20230131063928.388035-1-ajd@linux.ibm.com>
         <20230131063928.388035-20-ajd@linux.ibm.com>
         <5c335c29-ecb6-70eb-ab8e-caadde774434@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: keLy3LWDQ3lADihVWqrZMz-wTfKF0X8V
X-Proofpoint-ORIG-GUID: 7rgOvipZPeOTAfmpqpzrtsmAs6LUkjzc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=743 phishscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302070044
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2023-01-31 at 11:38 -0500, Stefan Berger wrote:
>=20
>=20
> On 1/31/23 01:39, Andrew Donnellan wrote:
> > Currently, plpks_read_var() allocates a buffer to pass to the
> > H_PKS_READ_OBJECT hcall, then allocates another buffer, of the
> > caller's
>=20
>=20
> -> buffer of the (no comma)

I'll just remove that clause entirely, it's not really necessary


--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited
