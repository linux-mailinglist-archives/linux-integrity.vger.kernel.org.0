Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFA0525317
	for <lists+linux-integrity@lfdr.de>; Thu, 12 May 2022 18:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356748AbiELQ5Z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 May 2022 12:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356747AbiELQ5X (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 May 2022 12:57:23 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B71D527C7;
        Thu, 12 May 2022 09:57:22 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CGrGbH026828;
        Thu, 12 May 2022 16:57:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=OXuueVf6s3X6JCfPwwHQM04N6RRuZKVbCAo/pD8gmoE=;
 b=dEosWFIzVsDsbbtzhV1OnaOE9QKKGrrtJsChiEBl5p0RrQsEs1b4cyux8gVYqiE7KOk4
 srho2/2gHQjf/zeTJ+1lNg0cCXYf5aUINuam4yBRjnvzFk86d6I1vOaj3AguHvLjGo//
 j9uEz9mXePTSHuPVflIw5ZWEoQU7sLeL0uZB8LhhgjZqhZaKoyAoo9BkIHbGgjQTnmqa
 N4reKmoDgBgurQfeyplQgmAXCfVLCCeJigJ9PbGwLM0e3X27Z9C4vgB6fiYbTWIC8M22
 ngHgfiTFQk1UUId/cuRdndSVpaXyWvr5lDIipKOf/BrVdoJGnEBaT16TehP02SZglj4O rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g15pm0q0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 16:57:16 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24CGuAuQ009564;
        Thu, 12 May 2022 16:57:15 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g15pm0pyr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 16:57:15 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24CGnB3O011576;
        Thu, 12 May 2022 16:52:12 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3fwgd8ybrp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 16:52:12 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24CGqA7k45089078
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 16:52:10 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6BB61AE058;
        Thu, 12 May 2022 16:52:10 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 617BEAE04D;
        Thu, 12 May 2022 16:52:09 +0000 (GMT)
Received: from sig-9-65-70-87.ibm.com (unknown [9.65.70.87])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 May 2022 16:52:09 +0000 (GMT)
Message-ID: <24a84723b246c45a6525016d9cd5cd13d121a0bf.camel@linux.ibm.com>
Subject: Re: [PATCH] tpm: sleep at least <...> ms in tpm_msleep()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Johannes Holland <johannes.holland@infineon.com>,
        Nayna <nayna@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca
Date:   Thu, 12 May 2022 12:52:08 -0400
In-Reply-To: <eb9ef8aeab4c0284028c013a2c86b248719a46ae.camel@HansenPartnership.com>
References: <20220510112902.23213-1-johannes.holland@infineon.com>
         <YnvTSqRgYkWu0qgp@kernel.org>
         <99541f08e8b554dea59334005cafb0af978f9a05.camel@linux.ibm.com>
         <eb9ef8aeab4c0284028c013a2c86b248719a46ae.camel@HansenPartnership.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TIycx0oP3tEWP8P7EXEnK9UwVbyPMsgB
X-Proofpoint-GUID: QLPjj_TuljSeiaS3Yn7m6pKQtgsdcwFi
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-12_14,2022-05-12_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 malwarescore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120078
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2022-05-12 at 08:32 -0400, James Bottomley wrote:
> On Thu, 2022-05-12 at 08:21 -0400, Mimi Zohar wrote:
> > On Wed, 2022-05-11 at 18:16 +0300, Jarkko Sakkinen wrote:
> > > On Tue, May 10, 2022 at 01:29:03PM +0200, Johannes Holland wrote:
> > > > To comply with protocol requirements, minimum polling times must
> > > > often
> > > > be adhered to. Therefore, a macro like tpm_msleep() should sleep
> > > > at
> > > > least the given amount of time (not up to the given period). Have
> > > > tpm_msleep() sleep at least the given number of milliseconds.
> > > > 
> > > > Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
> > > > ---
> > > >  drivers/char/tpm/tpm.h | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> > > > index 2163c6ee0d36..0971b55fffe3 100644
> > > > --- a/drivers/char/tpm/tpm.h
> > > > +++ b/drivers/char/tpm/tpm.h
> > > > @@ -185,8 +185,8 @@ int tpm_pm_resume(struct device *dev);
> > > >  
> > > >  static inline void tpm_msleep(unsigned int delay_msec)
> > > >  {
> > > > -	usleep_range((delay_msec * 1000) - TPM_TIMEOUT_RANGE_US,
> > > > -		     delay_msec * 1000);
> > > > +	usleep_range(delay_msec * 1000, (delay_msec * 1000)
> > > > +		     + TPM_TIMEOUT_RANGE_US);
> > > >  };
> > > >  
> > > >  int tpm_chip_start(struct tpm_chip *chip);
> > > > -- 
> > > > 2.34.1
> > > > 
> > > 
> > > For this I would really like to hear a 2nd opinion from Nayna and
> > > Mimi.
> > 
> > This patch reverts commit 5ef924d9e2e8 ("tpm: use tpm_msleep() value
> > as max delay").    Are you experiencing TPM issues that require it?
> 
> I am:
> 
> https://lore.kernel.org/linux-integrity/1531328689.3260.8.camel@HansenPartnership.com/
> 
> I'm about 24h into a soak test of the patch with no TPM failure so far.
> I think it probably needs to run another 24h just to be sure, but it
> does seem the theory is sound (my TPM gets annoyed by being poked too
> soon) so reverting 5ef924d9e2e8 looks to be the correct action.  The
> only other ways I've found to fix this are either revert the
> usleep_range patch altogether or increase the timings:
> 
> https://lore.kernel.org/linux-integrity/1531329074.3260.9.camel@HansenPartnership.com/
> 
> Which obviously pushes the min past whatever issue my TPM is having
> even with 5ef924d9e2e8 applied.
> 
> Given that even the commit message for 5ef924d9e2e8 admits it only
> shaves about 12% off the TPM response time, that would appear to be an
> optimization too far if it's going to cause some TPMs to fail.

I'd like to understand how pervasive the problem is and which problem
Johannes Holland is trying to address.  Wasn't there already a patch to
limit TPM performance degradation to a single buggy TPM chip already
upstreamed?

thanks,

Mimi

