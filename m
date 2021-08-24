Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5914E3F6089
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Aug 2021 16:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237851AbhHXOiN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 Aug 2021 10:38:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15730 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237852AbhHXOiN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Aug 2021 10:38:13 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17OEaQIV088398;
        Tue, 24 Aug 2021 10:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=LscKHOmM4JXne0ldvl9TPd0dEiLHWZoKTEFyx0n/fFk=;
 b=Vt5FXLCTugPQWD9ChXt6LeboeDn2bqF/B+EuObl75hT2ljdFNqWEsUFjOmtuB8AepbA+
 wEmjaN2um8Z3RUgkRk79Dw5yXtfG+tIi1iybUnxkF7RM6Wn0MndCrVzC2LbYmNROndA+
 ZPb78OhAPtzrKssNQsfxKAjv0LFjnl/yN/dBNkmMuatOobejo6zAGalji0x+LG64+UfF
 JrxLeF8lk1Z7qs93J0nerCmF4Aak8+qohTz4jwMakuQ/zTU1eEuncTSctRAmzITG9bIT
 TFNgWJOKfqEltaEye4oRFsDHx4uY6TSOJX7lEmFHzHjeShMEVDr6r97FKW0LtlCr+6ZD QA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3amv09beb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Aug 2021 10:36:43 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17OEacmN089288;
        Tue, 24 Aug 2021 10:36:43 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3amv09bdt3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Aug 2021 10:36:43 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17OEXVaS004979;
        Tue, 24 Aug 2021 14:34:18 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3ajs48wbvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Aug 2021 14:34:17 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17OEYFQc54133198
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 14:34:15 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6709F42041;
        Tue, 24 Aug 2021 14:34:15 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 622124204C;
        Tue, 24 Aug 2021 14:34:10 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.88.64])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 24 Aug 2021 14:34:10 +0000 (GMT)
Message-ID: <9526a4e0be9579a9e52064dd590a78c6496ee025.camel@linux.ibm.com>
Subject: Re: [PATCH v4 00/12] Enroll kernel keys thru MOK
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Nayna <nayna@linux.vnet.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        David Howells <dhowells@redhat.com>
Cc:     keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, keescook@chromium.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
        scott.branden@broadcom.com, weiyongjun1@huawei.com,
        nayna@linux.ibm.com, ebiggers@google.com, ardb@kernel.org,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        lszubowi@redhat.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        pjones@redhat.com,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        Patrick Uiterwijk <patrick@puiterwijk.org>
Date:   Tue, 24 Aug 2021 10:34:09 -0400
In-Reply-To: <bffb33a3-d5b5-f376-9d7d-706d38357d1a@linux.vnet.ibm.com>
References: <20210819002109.534600-1-eric.snowberg@oracle.com>
         <fcb30226f378ef12cd8bd15938f0af0e1a3977a2.camel@kernel.org>
         <f76fcf41728fbdd65f2b3464df0821f248b2cba0.camel@linux.ibm.com>
         <91B1FE51-C6FC-4ADF-B05A-B1E59E20132E@oracle.com>
         <e7e251000432cf7c475e19c56b0f438b92fec16e.camel@linux.ibm.com>
         <cedc77fefdf22b2cec086f3e0dd9cc698db9bca2.camel@kernel.org>
         <bffb33a3-d5b5-f376-9d7d-706d38357d1a@linux.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: r_swUgDIao0jShx0mbE5bkkPhHhggCoq
X-Proofpoint-GUID: SQpjP5z9YPQ9zB2BIjFB6bvDvc41h9gG
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-24_05:2021-08-24,2021-08-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108240094
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> >> Jarkko, I think the emphasis should not be on "machine" from Machine
> >> Owner Key (MOK), but on "owner".  Whereas Nayna is focusing more on the
> >> "_ca" aspect of the name.   Perhaps consider naming it
> >> "system_owner_ca" or something along those lines.

> > What do you gain such overly long identifier? Makes no sense. What
> > is "ca aspect of the name" anyway?
> 
> As I mentioned previously, the main usage of this new keyring is that it 
> should contain only CA keys which can be later used to vouch for user 
> keys loaded onto secondary or IMA keyring at runtime. Having ca in the 
> name like .xxxx_ca, would make the keyring name self-describing. Since 
> you preferred .system, we can call it .system_ca.

Sounds good to me.  Jarkko?

thanks,

Mimi

