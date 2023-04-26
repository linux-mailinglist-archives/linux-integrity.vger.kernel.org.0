Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0538C6EFC79
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Apr 2023 23:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239706AbjDZV3h (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Apr 2023 17:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239976AbjDZV3b (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Apr 2023 17:29:31 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B0F3AAF
        for <linux-integrity@vger.kernel.org>; Wed, 26 Apr 2023 14:29:24 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QLSGXL018901;
        Wed, 26 Apr 2023 21:29:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=10gKWDjFDxrv8CVePKst5pueFNsLDH7puI9LZiaCCb8=;
 b=qmyEAgqBUU82PEOPux7kLqK1s74QfSltxJh+6KWWZ5i+lzkscE2EJ44ecLxZgu4zimWu
 DY9XJTA7MzT7TOP/mPF1rfX3wDYh1J+3OMepoRqqlijDrPtoahLK7IK2SNJgzsjzkwGM
 xftguCRDazIk4eaq8QAgc0ods1GWQ+UjJ/HguaR30COoNihYwe+VI3QraDUc9N0ThgzN
 aFwiUixoQ9bWucA69ZW+UGO0EARP9/Y21NslCyx96U8S1zGmp0yvS3rRXTf21/8Y3Dig
 K7i6Pxf5aAEZNY7o/OFlkq0fCCZpRNSO47WRA+Gfhvc6q6hQUoEMGVcyAxx6AxKdkrZN Og== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q7b8f90ur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Apr 2023 21:29:22 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33QIeDDW018455;
        Wed, 26 Apr 2023 21:29:22 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3q4778n53u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Apr 2023 21:29:21 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33QLTJ7238928686
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Apr 2023 21:29:20 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8E5C58056;
        Wed, 26 Apr 2023 21:29:19 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7958058052;
        Wed, 26 Apr 2023 21:29:19 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.75.51])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 26 Apr 2023 21:29:19 +0000 (GMT)
Message-ID: <ac3fcf0ad3f992dc5e1fded680b13806ecea7180.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v2 2/2] examples: Add examples for
 elliptic curve key and certs generation
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     Eric Snowberg <eric.snowberg@oracle.com>
Date:   Wed, 26 Apr 2023 17:29:09 -0400
In-Reply-To: <8c84360c-285a-7492-275a-5552580b8535@linux.ibm.com>
References: <20230425161015.593988-1-stefanb@linux.ibm.com>
         <20230425161015.593988-3-stefanb@linux.ibm.com>
         <19fb6105c7343810a879a52421d847ab665bd8e9.camel@linux.ibm.com>
         <8c84360c-285a-7492-275a-5552580b8535@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ctn-gmh4lbM68RlHJZOWdp7GlhufUY_I
X-Proofpoint-GUID: ctn-gmh4lbM68RlHJZOWdp7GlhufUY_I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_10,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304260183
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2023-04-26 at 10:20 -0400, Stefan Berger wrote:
> 
> On 4/26/23 09:58, Mimi Zohar wrote:
> 
> > In preparation to allowing only code signing keys on the IMA keyring,
> > please add "extendedKeyUsage=critical,codeSigning",
> > 
> >> +subjectKeyIdentifier=hash
> >> +authorityKeyIdentifier=keyid
> >> +#authorityKeyIdentifier=keyid,issuer
> >> +__EOF__
> >> +
> >> +openssl req -new -nodes -utf8 -sha1 -days 365 -batch -config $GENKEY \
> > 
> > And similarly change sha1 to sha256 here.
> 
> Should we make all these changes first to the existing scripts for RSA keys?

Definitely.

Please also update the "doc_DATA" in Makefile.am to include the new
scripts.

-- 
thanks,

Mimi

