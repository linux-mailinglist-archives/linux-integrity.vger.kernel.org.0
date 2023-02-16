Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A326995FA
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Feb 2023 14:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjBPNlE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Feb 2023 08:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjBPNk5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Feb 2023 08:40:57 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8665455C
        for <linux-integrity@vger.kernel.org>; Thu, 16 Feb 2023 05:40:55 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31GCmDBR029594;
        Thu, 16 Feb 2023 13:40:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=TBh4oylSVQmqxAq6PoYwEfkJSRRuWASDCC1zmzK/l2Y=;
 b=IFORGn6XR48H2eC0TCmSP6MR+YD8ZBt/5qBCFHSCOpxZS/6uGdXEVxFnJ/J/4C5qLMPq
 bqjBWnJstoHoLD1ADlR7YhTtwE0E/61y1WKE/3hJNINrSPM3waHeAA7lIsJ/uZEISgwR
 RS2/9XeZl9zvYNN2Z62+Ztf9uu88tvUWIMavFM24NE/5D23NXuUOwR3K97RPMdbzoA6c
 aQ+KegRv7Y41wqNDOughf0TJ8jscTLY7Jwi7uyKFYyxbTbbpZ/BrWbkAGujwXipmc/rK
 fHWtuilFQQO95yLOcRYXprk10N/QK4QKE+R1xXJpyCP4yxtkXjboQXQ2QLDjstfMtK9w wg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nsgebqvwk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 13:40:38 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31GCPw1S021054;
        Thu, 16 Feb 2023 13:40:38 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nsgebqvw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 13:40:37 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31GBxKNe019914;
        Thu, 16 Feb 2023 13:40:37 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3np2n7apxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 13:40:37 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31GDeaH35309114
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Feb 2023 13:40:36 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 411AC58054;
        Thu, 16 Feb 2023 13:40:36 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 543DF5803F;
        Thu, 16 Feb 2023 13:40:35 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.163.119])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 16 Feb 2023 13:40:35 +0000 (GMT)
Message-ID: <20ff32785d8279b140cb5979975dcfd71195cccd.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v2] Add ima_policy_check.awk and
 ima_policy_check.test
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Thu, 16 Feb 2023 08:40:34 -0500
In-Reply-To: <6dc1c55d499187c55dbf88b19b52c3923001b8af.camel@huaweicloud.com>
References: <20230214152258.3553294-1-roberto.sassu@huaweicloud.com>
         <f00d6ea8df825b38f1df62cd2487fb4467c7ab48.camel@linux.ibm.com>
         <c462ad3e9b77990691b3cf0aff64ea64a5d77586.camel@huaweicloud.com>
         <87c98608540c6b482614ac90bcf7819c3fd058e5.camel@linux.ibm.com>
         <6dc1c55d499187c55dbf88b19b52c3923001b8af.camel@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TH0_IDIbmdcTkCoEGIYkTU2W65hciJbd
X-Proofpoint-ORIG-GUID: eMFccCFsPFLPUHfCKH4WV-lsgyMd0X9N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_10,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 impostorscore=0 suspectscore=0
 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302160116
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2023-02-16 at 14:30 +0100, Roberto Sassu wrote:
> > > > > +# Rules don't overlap if there is at least one policy keyword (in base or lsm)
> > > > > +# providing a different value.
> > > > 
> > > > The above comment needs to be updated to reflect the overlapping tests.
> > > 
> > > Not sure what is missing. Maybe: rules don't overlap also when they are
> > > equivalent (they have the same keys and values)?
> > 
> > The above "overlap" definition doesn't take into account one rule being
> > more restrictive (having more "keys" than the other.)
> 
> Ok, I see.
> 
> Rules don't overlap if both include the same policy keyword (in base or
> lsm), at least one, with a different value.

^keyword(s)

-- 
thanks,

Mimi

