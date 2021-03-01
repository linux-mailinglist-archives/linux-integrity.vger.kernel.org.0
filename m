Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154E0327F1B
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Mar 2021 14:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbhCANMa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Mar 2021 08:12:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1620 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235381AbhCANM2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Mar 2021 08:12:28 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 121D47DD154971;
        Mon, 1 Mar 2021 08:11:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=tJ9ufPL3b03q4eIjrN7DuEgd4aWZDYb3QhchfQ4FRbI=;
 b=j8Y2IacpCeG31mBIQisurejZbgnX9kjSdByPP/jdWaxfRURSVQmyv+2d+E+ShnbJOM1z
 ODjptmUvTr34UxjNOtJt5eBCh8ksvv1fJ7thC1R9cdbq9vsvPigIjuIn/1zueRNZM/XH
 s5fntKr1877MaedAD+IKBcgPE7dq6rnAvRVoMBtKKKHuKiOyjOqyX0RqiHIu1KwVUNcG
 NxGn0wvA9Lvk7Y6GcUTszd19HhqjO1n4bvOaaGHQp6yxE1U0VE9PtClV9XCeK836rMcD
 9BkNGa7e8AyK7W8R9aPxrqYsIu4g7a2GyEQofsC/N5HkxQu6jkd30ppTg2RIxyIpNL3u dA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3710tk0a9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Mar 2021 08:11:34 -0500
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 121D4RKT161377;
        Mon, 1 Mar 2021 08:11:34 -0500
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3710tk0a8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Mar 2021 08:11:34 -0500
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 121D7nsY002485;
        Mon, 1 Mar 2021 13:11:31 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 36yj530w1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Mar 2021 13:11:31 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 121DBSGG30343558
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Mar 2021 13:11:28 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BDA174C04E;
        Mon,  1 Mar 2021 13:11:28 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADCCE4C046;
        Mon,  1 Mar 2021 13:11:25 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.103.165])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  1 Mar 2021 13:11:25 +0000 (GMT)
Message-ID: <8618fdb7107ec6ec1aeb4e37faf82421050bdf91.camel@linux.ibm.com>
Subject: Re: [PATCH v9 9/9] certs: Add support for using elliptic curve keys
 for signing modules
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     yumeng <yumeng18@huawei.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com
Cc:     linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Date:   Mon, 01 Mar 2021 08:11:24 -0500
In-Reply-To: <ce098224-893c-fba8-5995-a7bac90f82c2@huawei.com>
References: <20210225160802.2478700-1-stefanb@linux.vnet.ibm.com>
         <20210225160802.2478700-10-stefanb@linux.vnet.ibm.com>
         <ce098224-893c-fba8-5995-a7bac90f82c2@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-01_08:2021-03-01,2021-03-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103010108
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2021-02-27 at 11:35 +0800, yumeng wrote:
> 在 2021/2/26 0:08, Stefan Berger 写道:
> > From: Stefan Berger <stefanb@linux.ibm.com>
> > 
> 
> > diff --git a/certs/Makefile b/certs/Makefile
> > index 3fe6b73786fa..c487d7021c54 100644
> > --- a/certs/Makefile
> > +++ b/certs/Makefile
> > @@ -69,6 +69,18 @@ else
> >   SIGNER = -signkey $(obj)/signing_key.key
> >   endif # CONFIG_IMA_APPRAISE_MODSIG
> >   
> 
> Is there anything wrong in this patch?
> I can't apply it when I use 'git am '.
> errors like below:
> 
> error: certs/Kconfig: does not match index
> error: patch failed: certs/Makefile:69
> error: certs/Makefile: patch does not apply
> 
> Thanks

Nothing wrong with the patch, just a dependency.  From the Change log:
   - This patch builds on top Nayna's series for 'kernel build support
   for loading the kernel module signing key'.
   - https://lkml.org/lkml/2021/2/18/856

thanks,

Mimi


