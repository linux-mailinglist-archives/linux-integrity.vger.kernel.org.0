Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3127A6523CB
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Dec 2022 16:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiLTPlM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Dec 2022 10:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiLTPlK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Dec 2022 10:41:10 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF93FFCF1
        for <linux-integrity@vger.kernel.org>; Tue, 20 Dec 2022 07:41:07 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BKFbiVm021257;
        Tue, 20 Dec 2022 15:41:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=oAwZ66nM3AQJ/t71rt3/egG6mCHpbQ5G8f9GR2c7W44=;
 b=EwDEKjObHyn3tYVu/hhOsu4uajLjHMvDJxsOHt9LmfgTdAdBsJz5P8zwmj1ise0SlK8z
 SIPSsSOcKOawuRNLEExWpPJZ/y6UC0ZjzLEJ11Ybd7cu1ItN+JmyWGeInrk3ccfEL92i
 KWT4jfiUi1Pk7twEfVpseKQ6SdAGB4gk+5vLLyBo+X/pEVeDiECH9aqPuSaXb984EJw4
 ZZnJM+xa9k02u0KOgxsUEQ0tIweqVVuetMTmHZrGtVqudW8wO/USSjW7sHzQtgsUnIll
 o3ymSzb6ObU/v3MVIQZNTLb1NEl7g1FCA8BmBmtwS1zoMwUoAeozri1Qm0qy8QnYOzcH yA== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mkfur04ah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Dec 2022 15:41:04 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BKEwA00016851;
        Tue, 20 Dec 2022 15:40:51 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3mh6yxn7r0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Dec 2022 15:40:51 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BKFenDd5833380
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Dec 2022 15:40:50 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E166C58058;
        Tue, 20 Dec 2022 15:40:49 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7046458054;
        Tue, 20 Dec 2022 15:40:49 +0000 (GMT)
Received: from sig-9-77-154-80.ibm.com (unknown [9.77.154.80])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 20 Dec 2022 15:40:49 +0000 (GMT)
Message-ID: <3690af5fa39078b8e542940cf5db50c0b6663aa3.camel@linux.ibm.com>
Subject: Re: Question on loading trusted key with keyctl command
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Sughosh Ganu <sughosh.ganu@linaro.org>
Cc:     linux-integrity@vger.kernel.org
Date:   Tue, 20 Dec 2022 10:40:48 -0500
In-Reply-To: <89ed5619ff41ea8a3651e3388ff7309b13646896.camel@HansenPartnership.com>
References: <CADg8p96Obiio+CUOCKzKqqc6m+B+zSDgs6SWLKSpSo5po94ApQ@mail.gmail.com>
         <ddefa55ad5c5f0dc0248a4017ea31e8e5d7a5328.camel@HansenPartnership.com>
         <CADg8p972AxWMTQbAXc=+zX9STtLdRKUmopbjEbq0rfFP_TKwrg@mail.gmail.com>
         <e26b33be6ae53d4b566cffda092bcd45a3691c06.camel@HansenPartnership.com>
         <5e1c8d3bd5742979e328a267522347ad39b483a3.camel@linux.ibm.com>
         <d8df26bb38ac342ab32c31ba0b5f17da4c79560a.camel@HansenPartnership.com>
         <555e740263323e4dddecc48224717a5baad145ee.camel@linux.ibm.com>
         <89ed5619ff41ea8a3651e3388ff7309b13646896.camel@HansenPartnership.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6yrFPIg3Qbtb16Kn2nWeHHVsDBDeKT4_
X-Proofpoint-ORIG-GUID: 6yrFPIg3Qbtb16Kn2nWeHHVsDBDeKT4_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-20_05,2022-12-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212200124
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-12-20 at 09:23 -0500, James Bottomley wrote:
> On Tue, 2022-12-20 at 09:13 -0500, Mimi Zohar wrote:
> > On Tue, 2022-12-20 at 09:03 -0500, James Bottomley wrote:
> > > On Tue, 2022-12-20 at 08:54 -0500, Mimi Zohar wrote:
> > > > On Tue, 2022-12-20 at 07:50 -0500, James Bottomley wrote:
> > > > > On Tue, 2022-12-20 at 12:03 +0530, Sughosh Ganu wrote:
> > > [...]
> > > > > > I was able to load the key after clearing the keyring. Thanks
> > > > > > James and Mimi for your pointers.
> > > > > 
> > > > > Actually, I think this is a bug in trusted keys.  Add on
> > > > > existing key is supposed to go through the update path.  If the
> > > > > path doesn't exist it returns -EEXIST.  Trusted keys have an
> > > > > update path but they return - EINVAL if the trusted key command
> > > > > is anything but update (which is used to reseal a key). 
> > > > > Obviously this is incorrect and the code should be returning -
> > > > > EEXIST for a key we refuse to update to match every other key
> > > > > type.
> > > > 
> > > > Re-loading an existing key was previously permitted.  Obviously
> > > > this changed at some point.   Any "fixes" should point out when
> > > > it changed.
> > > 
> > > Git history doesn't think so.  It thinks when you    added trusted
> > > keys with d00a1c72f7f4661212299e6cb132dfa58030bcdb the update path
> > > already had the -EINVAL return, so reload has always failed this
> > > way unless we were doing a reseal update.  We could certainly
> > > permit overwriting an existing key with load, but that would be a
> > > more extensive change.
> > 
> > Replacing existing keys/keyrings was part of the infrastructure.  I
> > don't think this change has anything to do with trusted type keys.  
> > The ability of replacing keys/keyrings was one of the main reasons
> > for trusted keyrings (dot prefixed keyrings).
> 
> Keys can only be replaced by calling the ->update() helper for the key
> type.  If that doesn't exist keyctl add will return -EEXIST (behaviour
> for at least the last 12 years).  Most key type update routines do
> unconditionally update, so the error they return is the same error they
> would have returned for an add of a non existent key (EINVAL if the
> payload is too large, for instance).  The trusted keys ->update()
> helper (trusted_update()) only allows update if the trusted operation
> is update, so they've always failed a load with EINVAL going back to
> the original commit I quoted.  At no time that I can find has there
> ever been a modification to this supporting updating trusted keys with
> anything other than an update trusted operation.  So they've supported
> changing the sealing parameters (PCR values) but not changing the
> payload.  This contrasts with user keys where add of a new payload on
> an existing key changes the payload.

Yes, my mistake.  With your change, it's now returning "add_key: File
exists".

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
-- 
thanks,

Mimi

