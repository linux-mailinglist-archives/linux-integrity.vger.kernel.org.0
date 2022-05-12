Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BBE524C99
	for <lists+linux-integrity@lfdr.de>; Thu, 12 May 2022 14:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353630AbiELMVc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 May 2022 08:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353632AbiELMVb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 May 2022 08:21:31 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D8D62235;
        Thu, 12 May 2022 05:21:29 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CCJDnq014644;
        Thu, 12 May 2022 12:21:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=bCU0bOeBXG5Y6DNauHOVFi5fNBXbyQkfeBK2dG8rdvw=;
 b=ZjvQU0ZHGwtBdLWlUg+S2cVl1S5V40JJA0RHaSjyZrAXWD5cDXPJTl2d5Qr51ZUKK3j3
 8aNKwMtM0XLmdU10c8ANHjdStcRmShtDxnJanaiJQVZlv7W6n2TtbZadg5MVTVyl7w2W
 0pB2Sg/EOxoPLKFR6QfQgMTBKzL3IOsbIsEKVLy7I2uPrfwHX2p/oqzlCyiMWNJPS+rK
 AaGjIy38aH6mHN+DWVpwohkxa89DYJX7EFcLefhyvw32iSz/gHkSON6heSI4J2GNu8VA
 T+wlisDnvWy8IzpyQ8ujNtKQQvZ7LnAOolXpoE+JYP1sLv9WaHI7jOWDdAJ3oyBlU3Ct PQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g124rg1u1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 12:21:24 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24CCKCMV019771;
        Thu, 12 May 2022 12:21:24 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g124rg1sr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 12:21:23 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24CCJdYr001036;
        Thu, 12 May 2022 12:21:22 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 3fwgd8wg5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 12:21:21 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24CCLJTo52560360
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 12:21:19 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B378A4054;
        Thu, 12 May 2022 12:21:19 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5ACD7A405B;
        Thu, 12 May 2022 12:21:18 +0000 (GMT)
Received: from sig-9-65-70-87.ibm.com (unknown [9.65.70.87])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 May 2022 12:21:18 +0000 (GMT)
Message-ID: <99541f08e8b554dea59334005cafb0af978f9a05.camel@linux.ibm.com>
Subject: Re: [PATCH] tpm: sleep at least <...> ms in tpm_msleep()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Johannes Holland <johannes.holland@infineon.com>,
        Nayna <nayna@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca
Date:   Thu, 12 May 2022 08:21:17 -0400
In-Reply-To: <YnvTSqRgYkWu0qgp@kernel.org>
References: <20220510112902.23213-1-johannes.holland@infineon.com>
         <YnvTSqRgYkWu0qgp@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zx-3t_x1YUzXSSJZt9EnPRcjXHiHQJ8i
X-Proofpoint-ORIG-GUID: INxetDhYIMU4i4YGIGUtGGi-9gmPTIp5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-12_10,2022-05-12_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 spamscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1011
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120056
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2022-05-11 at 18:16 +0300, Jarkko Sakkinen wrote:
> On Tue, May 10, 2022 at 01:29:03PM +0200, Johannes Holland wrote:
> > To comply with protocol requirements, minimum polling times must often
> > be adhered to. Therefore, a macro like tpm_msleep() should sleep at
> > least the given amount of time (not up to the given period). Have
> > tpm_msleep() sleep at least the given number of milliseconds.
> > 
> > Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
> > ---
> >  drivers/char/tpm/tpm.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> > index 2163c6ee0d36..0971b55fffe3 100644
> > --- a/drivers/char/tpm/tpm.h
> > +++ b/drivers/char/tpm/tpm.h
> > @@ -185,8 +185,8 @@ int tpm_pm_resume(struct device *dev);
> >  
> >  static inline void tpm_msleep(unsigned int delay_msec)
> >  {
> > -	usleep_range((delay_msec * 1000) - TPM_TIMEOUT_RANGE_US,
> > -		     delay_msec * 1000);
> > +	usleep_range(delay_msec * 1000, (delay_msec * 1000)
> > +		     + TPM_TIMEOUT_RANGE_US);
> >  };
> >  
> >  int tpm_chip_start(struct tpm_chip *chip);
> > -- 
> > 2.34.1
> > 
> 
> For this I would really like to hear a 2nd opinion from Nayna and Mimi.

This patch reverts commit 5ef924d9e2e8 ("tpm: use tpm_msleep() value as
max delay").    Are you experiencing TPM issues that require it?

thanks,

Mimi


