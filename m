Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46B2F3E5003
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Aug 2021 01:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235543AbhHIXes (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Aug 2021 19:34:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9598 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233018AbhHIXes (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Aug 2021 19:34:48 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179NWiX9171926;
        Mon, 9 Aug 2021 19:34:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=NNN13Ge2HOYu0HROjbcLiO3eZLwcFColRyjn4Po254g=;
 b=cjdDpup85u97qSzLI5+B9TdBi2oSAezMqTmZGXu2Pe15FA8mtU6ujn6qCH8lQjCdVZDW
 ZBGuUXQ4SwBjOaJYT0fV8WnRuZDQ1XUAJGycKPXk8Ye9mvSHhnLktwAWRkbJ0gvnHT8A
 38BLCcFScfMlQd+QFm/lRsOhbmLTRaqBmiZOrIMiGMlyl0RWY9d1pggA++kT0sBepP4Y
 s6JrJAoSKwGAaxaz20xF/yxnpSnv5ldjJvodSiOoxKSq+glqhMN8UWEI5jn1aPAhhfDr
 OlP4Ep7jcC/pFQsBgqAskEHWhHZp5SY7DjL3SkuwqAzPOynBW1pgIAdnY4ZYDwylj1qM Ng== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ab4j0ysf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Aug 2021 19:34:24 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 179NYOgw177606;
        Mon, 9 Aug 2021 19:34:24 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ab4j0yser-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Aug 2021 19:34:24 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 179NSIVJ005171;
        Mon, 9 Aug 2021 23:34:22 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3a9ht8vwqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Aug 2021 23:34:22 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 179NYKux50266502
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Aug 2021 23:34:20 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 245565204E;
        Mon,  9 Aug 2021 23:34:20 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.60.134])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id EE5B152051;
        Mon,  9 Aug 2021 23:34:18 +0000 (GMT)
Message-ID: <1381b22a98d7b43b7cba9f79fc0b739ed2816a5f.camel@linux.ibm.com>
Subject: Re: [PATCH v6 2/5] IMA: block writes of the security.ima xattr with
 unsupported algorithms
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
Date:   Mon, 09 Aug 2021 19:34:17 -0400
In-Reply-To: <20210804092010.350372-3-simon.thoby@viveris.fr>
References: <20210804092010.350372-1-simon.thoby@viveris.fr>
         <20210804092010.350372-3-simon.thoby@viveris.fr>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DgsnfMbn169gRPRH7cVtsus3mozpmlwm
X-Proofpoint-GUID: jISGohOm1njpW4nZukoTZhycZgdDFzaV
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-09_09:2021-08-06,2021-08-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108090165
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-08-04 at 09:20 +0000, THOBY Simon wrote:
> +static int validate_hash_algo(struct dentry *dentry,
> +                                  const struct evm_ima_xattr_data *xattr_value,
> +                                  size_t xattr_value_len)
> +{
> +       int result = 0;
> +       char *path = NULL, *pathbuf = NULL;
> +       enum hash_algo xattr_hash_algo;
> +
> +       xattr_hash_algo = ima_get_hash_algo(xattr_value, xattr_value_len);
> +
> +       if (likely(xattr_hash_algo == ima_hash_algo ||
> +                  crypto_has_alg(hash_algo_name[xattr_hash_algo], 0, 0)))
> +               return result;
> +
> +       result = -EACCES;
> +
> +       pathbuf = kmalloc(PATH_MAX, GFP_KERNEL);
> +       if (!pathbuf)
> +               return result;
> +
> +       path = dentry_path(dentry, pathbuf, PATH_MAX);
> +
> +       integrity_audit_msg(AUDIT_INTEGRITY_DATA, d_inode(dentry), path,
> +                           "collect_data", "unavailable-hash-algorithm",
> +                           result, 0);

"collect_data" refers to calculating the file hash,
ima_collect_measurement(), which may be stored in the measurement list,
used for verifying the signature and/or included in the audit record.

validate_hash_algo() verifies the hash algorithm before allowing the
file hash or signature to be written as security.ima.  Instead of
"collect_data" it should be "set_data" or something similar.

thanks,

Mimi

> +
> +       kfree(pathbuf);
> +
> +       return result;


