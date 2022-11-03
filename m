Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2481B618AA7
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Nov 2022 22:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiKCVfu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Nov 2022 17:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbiKCVft (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Nov 2022 17:35:49 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEEB1EEFE
        for <linux-integrity@vger.kernel.org>; Thu,  3 Nov 2022 14:35:48 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3KuYm6015154;
        Thu, 3 Nov 2022 21:35:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Sgz7YoyM0GMKM72RqwWTNCYiyls+bbnIajQ9lqYz6+w=;
 b=dLP62EpsVFnIklL9+R3E1WmUtJnPIbPnVPliNTMIBDwNGe+J8p4pgzCfdteUqueW1eSL
 fYru6b6Pe2/pB6P+LlKPJCbnuZxrHRRGVgexZJF17cXWxOMGvxd6fFdAb/C288Hq6tfl
 mEXyLZlZmkBRs74MWuY9QGb3mnnYyRIflTOofdxI7oQHzq3uy5m3tM0qh8/E5FUF65fp
 59NMUoVbVoA6msPNZhuraMlO6/sG8kC6qHE260GfhGqeKH2UfVPqlc1/PZ1iBbWuArmk
 cYdsI0zHY4G9U17HcaL4TntvCK/Zj2d5Zvt88+5jknOIDy6v+ADrvy5xSWYhPRvofrW7 LA== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kme7yrj31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 21:35:43 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A3LKIwZ025965;
        Thu, 3 Nov 2022 21:35:42 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma01wdc.us.ibm.com with ESMTP id 3kguta46hr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 21:35:42 +0000
Received: from smtpav01.dal12v.mail.ibm.com ([9.208.128.133])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A3LZfV159244970
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Nov 2022 21:35:41 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A7A158059;
        Thu,  3 Nov 2022 21:35:41 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9B3758057;
        Thu,  3 Nov 2022 21:35:40 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.20.100])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  3 Nov 2022 21:35:40 +0000 (GMT)
Message-ID: <6641d0eec7dd91d0d8b2f5dbf1844173a79b13fe.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v4 01/17] Revert "Reset 'errno' after
 failure to open or access a file"
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>
Date:   Thu, 03 Nov 2022 17:35:40 -0400
In-Reply-To: <Y2PREKTdNQhwhPEK@pevik>
References: <20221101201803.372652-1-zohar@linux.ibm.com>
         <20221101201803.372652-2-zohar@linux.ibm.com>
         <0a70ffe5-a35a-f8fa-dfa8-be3bf2e5e29f@linux.ibm.com>
         <145f4c70ec894c4980d9455485cdac4673e01d04.camel@linux.ibm.com>
         <52e19952-a1c3-722e-2267-a625e16c37a2@linux.ibm.com>
         <4db89eab7d21124aa7945ccf4fd150c3ee4d259c.camel@linux.ibm.com>
         <Y2PREKTdNQhwhPEK@pevik>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: c0bHWNvx-3FGUn5oqd2Q-j-Oc7S6VfLC
X-Proofpoint-ORIG-GUID: c0bHWNvx-3FGUn5oqd2Q-j-Oc7S6VfLC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 adultscore=0
 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030147
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Petr,

> > > Is the github repo now the main repo and sourceforge repo is dead?
> 
> > The "next" branch in both repo's are the same.  Before posting patches,
> > I verify that github Actions works.   As a result, the next-testing
> > branch on github is rebased frequently.  Once a patch set is ready, the
> > "next" branch in both repo's is updated.
> 
> > To answer your question the github repo is primary.
> Maybe deleting everything in sourceforge and ad put single file with link to
> github.com would save you work (having master, next and next-testing branches
> with this file).

Thanks, definitely appreciate time saving tips!  Vitaly suggested
saving the sourceforge wiki info in ima-evm-utils and updating the
file(s) like any other file.  Before removing "everything"h from
sourceforge, that still needs to be done.

-- 
thanks,

Mimi

