Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052C067803D
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Jan 2023 16:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbjAWPoT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 Jan 2023 10:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbjAWPoS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Jan 2023 10:44:18 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223EE93FA
        for <linux-integrity@vger.kernel.org>; Mon, 23 Jan 2023 07:44:10 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30NEla7a005174;
        Mon, 23 Jan 2023 15:43:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=CUbMdmziuTYPO4P56osSXuEeFy7gCqBdEU21wZtJOiA=;
 b=PEMiG9aCT9672rRMWgxNEXDRmAOxH3aWgAAG+Whbtz1njPM/iUIbtP8BD0ykfZAojno2
 rhkJd9hh9+flIfkel6dfjKbJrDtpwnWNjb+Lu+CCMkTASaKNnR3VvzfPwO4nnLf01ZgQ
 c6AdynJjFfwVnAovod+hwW3F08cvlDa1oOj0Y69c1+Wh5nkqSV0p1N8biHoWjTbkMgdj
 xLRHeCf+MBJS7QQ8nPxwFgjZjmBthlJrolFXx4BtFqOx9lH13ObC+nsf1W8gRU7LvEeV
 a9iREP4SPr7wPLFwJNC46EhYoueEZ6xhuAbedFNqeKXfXBLPdcQ1Mn9PYX/5NsmTcN5n /A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3n9tb9na30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 15:43:50 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30NElmta006150;
        Mon, 23 Jan 2023 15:43:49 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3n9tb9na2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 15:43:49 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30NE0rrJ010685;
        Mon, 23 Jan 2023 15:43:48 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3n87p6w4n1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 15:43:48 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30NFhlwF46203338
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jan 2023 15:43:47 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F56F5803F;
        Mon, 23 Jan 2023 15:43:47 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B35C15805A;
        Mon, 23 Jan 2023 15:43:46 +0000 (GMT)
Received: from sig-9-77-133-110.ibm.com (unknown [9.77.133.110])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 23 Jan 2023 15:43:46 +0000 (GMT)
Message-ID: <4237c8d0c61038abfce21aa461611305bbe19adc.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v2 6/9] Add tests for EVM portable
 signatures
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Mon, 23 Jan 2023 10:43:46 -0500
In-Reply-To: <724585556e02178d0b9ce29af057a93ac72f0a87.camel@huaweicloud.com>
References: <20230112122426.3759938-1-roberto.sassu@huaweicloud.com>
         <20230112122426.3759938-7-roberto.sassu@huaweicloud.com>
         <4b39d880d2ddfec667608222d7ca7a0eed5fe28b.camel@linux.ibm.com>
         <724585556e02178d0b9ce29af057a93ac72f0a87.camel@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: a_mIX0l8xwvZ2WCcWd6z1glFnJ4lLWI-
X-Proofpoint-GUID: qDby_4YSyEM3gsfp3-t67zoLjo_POGo_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_11,2023-01-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301230149
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-01-23 at 16:31 +0100, Roberto Sassu wrote:
> On Mon, 2023-01-23 at 09:40 -0500, Mimi Zohar wrote:
> > Hi Roberto,
> > 
> > On Thu, 2023-01-12 at 13:24 +0100, Roberto Sassu wrote:
> > > +
> > > +key_path="/lib/modules/$(uname -r)/source/certs/signing_key.pem"
> > > +if [ -f "$PWD/../signing_key.pem" ]; then
> > > +       key_path=$PWD/../signing_key.pem
> > > +fi
> > > +
> > 
> > For testing locally, how about first checking the file exists, before
> > setting key_path?  On not finding it, perhaps check whether
> > "/lib/modules/$(uname -r)/build/certs/signing_key.pem" exists.
> 
> The precedence is:
> 
> TST_KEY_PATH -> ../signing_key.pem -> /lib/modules...

This is still /lib/modules, just not "source/", but "build/".

-key_path="/lib/modules/$(uname -r)/source/certs/signing_key.pem"
+if [ -f "/lib/modules/$(uname -r)/source/certs/signing_key.pem" ]; then
+       key_path="/lib/modules/$(uname -r)/source/certs/signing_key.pem"
+elif [ -f "/lib/modules/$(uname -r)/build/certs/signing_key.pem" ]; then
+       key_path="/lib/modules/$(uname -r)/build/certs/signing_key.pem"
+fi
+

Mimi

> 
> If TST_KEY_PATH is not found, probably it is a good idea to not
> fallback to the other alternatives, as it is user input.



