Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B34378DCC2
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Aug 2023 20:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbjH3Sqh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Aug 2023 14:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244064AbjH3M1d (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Aug 2023 08:27:33 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DBACCF
        for <linux-integrity@vger.kernel.org>; Wed, 30 Aug 2023 05:27:31 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37UCNH8h016835;
        Wed, 30 Aug 2023 12:27:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=mfs07Teqy5wZ6u+jHlk+FanNz6jtvdeIs+VB0zTBTUw=;
 b=XjT0bPhYPZPFRDxHv9hc21rtMgtFBNwptfwrTpww4Yi9k2pQ/56fYYwFBY8UhQCgosjZ
 bQEdSjKZz23yNajcjnRUUQcHpLU105A81iPzZVQ+NhTA7yNh5Qamqv/TqQ/4M2bHZF+w
 SXlGPEm7ZOBtACHQccRW2jbv3Vvyj9xEjcd7tJVHm0WxgmqczcUCwioyVmIC25jXO+Em
 gyN22G6/2L49gXxml0lCFFppAlKjix9Fq5Hp/i7k0rgTYbZVXr1eb7e+5OuX6EhBD/Lt
 j7IwPLjKReD4FIotMircgWNUJUzYd5Pxi45qQ27VBmxq0OldAZ+NbhPEzEKDq7eux9Rf gg== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3st4hktc2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 12:27:19 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37U9uZ8D004888;
        Wed, 30 Aug 2023 12:27:18 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3squqsv2ye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 12:27:18 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37UCRIJ464356700
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 12:27:18 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB4A85805D;
        Wed, 30 Aug 2023 12:27:17 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B38958052;
        Wed, 30 Aug 2023 12:27:17 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.185.26])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 30 Aug 2023 12:27:17 +0000 (GMT)
Message-ID: <7dc816ddc48e50de32debafbeee9c83b728aec75.camel@linux.ibm.com>
Subject: Re: [RFC PATCH -next] ima: Make tpm hash configurable
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     "Guozihua (Scott)" <guozihua@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-integrity@vger.kernel.org
Date:   Wed, 30 Aug 2023 08:27:17 -0400
In-Reply-To: <47e478d8-1559-a3cc-94c1-a05fd79b2f0b@huawei.com>
References: <20230817061334.1910-1-guozihua@huawei.com>
         <90b4b5573182ec68b2da2f9ef2bc6567d724f8f1.camel@linux.ibm.com>
         <e2c5711c-6549-e81f-42a7-eec176b39d63@huawei.com>
         <97198ee38422fbb1891981ac5c41263d5b03b321.camel@linux.ibm.com>
         <47e478d8-1559-a3cc-94c1-a05fd79b2f0b@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: D3BNMc9l_ZW11zfXgcBudx1N1JVYe-K5
X-Proofpoint-ORIG-GUID: D3BNMc9l_ZW11zfXgcBudx1N1JVYe-K5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=760 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300113
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2023-08-30 at 17:14 +0800, Guozihua (Scott) wrote:
> On 2023/8/19 7:17, Mimi Zohar wrote:
> > On Fri, 2023-08-18 at 09:25 +0800, Guozihua (Scott) wrote:
> >> On 2023/8/17 22:19, Mimi Zohar wrote:
> >>> On Thu, 2023-08-17 at 14:13 +0800, GUO Zihua wrote:
> > [...]
> >  
> >>> Other proposals have changed the hard coded hash algorithm and PCR
> >>> value from SHA1 to SHA256.  Both that proposal and this will break
> >>> existing userspace applications.
> >>
> >> This is the part I would like to "RFC" on, and thanks for the comment!
> > 
> > Another proposal included all of the enabled TPM bank digests.
> Will this introduce some performance issue? I don't think we should be
> calculating various hashes on the same thing again and again.

Per TPM bank specific hashes are already being calculated and extended
into the TPM banks.  Refer to  ima_calc_field_array_hash().

-- 
thanks,

Mimi

