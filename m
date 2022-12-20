Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8609652224
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Dec 2022 15:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbiLTONY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Dec 2022 09:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbiLTONU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Dec 2022 09:13:20 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D33310EE
        for <linux-integrity@vger.kernel.org>; Tue, 20 Dec 2022 06:13:18 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BKEC3mJ026294;
        Tue, 20 Dec 2022 14:13:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=/cYtVLqFFu9DxInwnqXanARHBodSalfAmRr+rNhLGr4=;
 b=RvNAL9oqCqkye4GWqBbS/qc9doj2hGdjLFJOr1R63hVF0JAAMKTpf5TENGgvxJbf2b52
 +Rkj5UjlWe1/ZN7fj8l7ae1JJKb6BVHpBOKd4K3fxJuq2Y/ZHHuibLQQpADYINIvQbeQ
 gtgWPQMBx1upa4zKpKXBmHO6ESwm+Js+P4QCgbFQjtLCcK5OwfAzSnzxUPc/ZBVnz6K4
 +e83uGcc3LmxzowFs6rilyhdQrgopbTExVPWSBa1qNmdLOdI3EUT0sMHt+NQu2i06rl+
 daBUrOYvPBvEwAUlLMnlQ6GuZDJpd+zCCIWnv/zKLChmM87mGBTfirYzEEdpCyVwr5lM DQ== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mkekn03bt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Dec 2022 14:13:14 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BKCQeYY008294;
        Tue, 20 Dec 2022 14:13:03 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([9.208.130.99])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3mh6yx4r47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Dec 2022 14:13:03 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BKED2RX30278060
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Dec 2022 14:13:02 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F7BF58056;
        Tue, 20 Dec 2022 14:13:02 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE2175805D;
        Tue, 20 Dec 2022 14:13:01 +0000 (GMT)
Received: from sig-9-77-154-80.ibm.com (unknown [9.77.154.80])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 20 Dec 2022 14:13:01 +0000 (GMT)
Message-ID: <555e740263323e4dddecc48224717a5baad145ee.camel@linux.ibm.com>
Subject: Re: Question on loading trusted key with keyctl command
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Sughosh Ganu <sughosh.ganu@linaro.org>
Cc:     linux-integrity@vger.kernel.org
Date:   Tue, 20 Dec 2022 09:13:01 -0500
In-Reply-To: <d8df26bb38ac342ab32c31ba0b5f17da4c79560a.camel@HansenPartnership.com>
References: <CADg8p96Obiio+CUOCKzKqqc6m+B+zSDgs6SWLKSpSo5po94ApQ@mail.gmail.com>
         <ddefa55ad5c5f0dc0248a4017ea31e8e5d7a5328.camel@HansenPartnership.com>
         <CADg8p972AxWMTQbAXc=+zX9STtLdRKUmopbjEbq0rfFP_TKwrg@mail.gmail.com>
         <e26b33be6ae53d4b566cffda092bcd45a3691c06.camel@HansenPartnership.com>
         <5e1c8d3bd5742979e328a267522347ad39b483a3.camel@linux.ibm.com>
         <d8df26bb38ac342ab32c31ba0b5f17da4c79560a.camel@HansenPartnership.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jKCiuMevL29snwIQxlct3GHu3ZbZWiwK
X-Proofpoint-GUID: jKCiuMevL29snwIQxlct3GHu3ZbZWiwK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-20_05,2022-12-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212200116
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-12-20 at 09:03 -0500, James Bottomley wrote:
> On Tue, 2022-12-20 at 08:54 -0500, Mimi Zohar wrote:
> > On Tue, 2022-12-20 at 07:50 -0500, James Bottomley wrote:
> > > On Tue, 2022-12-20 at 12:03 +0530, Sughosh Ganu wrote:
> [...]
> > > > I was able to load the key after clearing the keyring. Thanks
> > > > James and Mimi for your pointers.
> > > 
> > > Actually, I think this is a bug in trusted keys.  Add on existing
> > > key is supposed to go through the update path.  If the path doesn't
> > > exist it returns -EEXIST.  Trusted keys have an update path but
> > > they return - EINVAL if the trusted key command is anything but
> > > update (which is used to reseal a key).  Obviously this is
> > > incorrect and the code should be returning -EEXIST for a key we
> > > refuse to update to match every other key type.
> > 
> > Re-loading an existing key was previously permitted.  Obviously this
> > changed at some point.   Any "fixes" should point out when it
> > changed.
> 
> Git history doesn't think so.  It thinks when you    added trusted keys
> with d00a1c72f7f4661212299e6cb132dfa58030bcdb the update path already
> had the -EINVAL return, so reload has always failed this way unless we
> were doing a reseal update.  We could certainly permit overwriting an
> existing key with load, but that would be a more extensive change.

Replacing existing keys/keyrings was part of the infrastructure.  I
don't think this change has anything to do with trusted type keys.  
The ability of replacing keys/keyrings was one of the main reasons for
trusted keyrings (dot prefixed keyrings).

-- 
thanks,

Mimi

