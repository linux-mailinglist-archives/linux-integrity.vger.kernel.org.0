Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87B24C199D
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Feb 2022 18:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243208AbiBWRNI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Feb 2022 12:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243301AbiBWRM4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Feb 2022 12:12:56 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6954E216;
        Wed, 23 Feb 2022 09:12:28 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21NGNPZu008842;
        Wed, 23 Feb 2022 17:12:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=i7a7ev+TSToZOoDITIyGq1Q0Jh67k8rK12gkyQZVitk=;
 b=qfiB00L18eYwIJ4dcgp+nVidsxXO/jALnC0A8yOv/5dyzQWPvIWjXpl8pmd9Eam0UkMZ
 8uFyft8YsV/bliVgyhJmJ6CVIOAKzFNZK6Bhdd5lI1ND48/ceIDOzW62+TH9ARgv80f0
 dwY/Yq3YUfEm+9lY9kkPlISwJK+YSNd0tngx6uUqFMP1yjIsXqnWn0O4EKULIQ+IzNuG
 CbnRy5at002RxYp45gbf8eap5faqh29N8lKdkqfE9XyKPXCWbCDOgGeXNxBwppM/jk+i
 ocZjs7H6zGCehwXkXBFUBO5p2WtCzZMq58IbEbxGG7UVXzmHhrKIDZJo0aaB7y7oqX2T eA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3edkxg092j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 17:12:14 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21NGvX71002924;
        Wed, 23 Feb 2022 17:12:14 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3edkxg091f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 17:12:14 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21NH6lnw028313;
        Wed, 23 Feb 2022 17:12:11 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 3ear69a3xy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 17:12:11 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21NHC8QY29884898
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 17:12:08 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EBF2F11C050;
        Wed, 23 Feb 2022 17:12:07 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 998A211C04A;
        Wed, 23 Feb 2022 17:12:05 +0000 (GMT)
Received: from sig-9-65-80-154.ibm.com (unknown [9.65.80.154])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 23 Feb 2022 17:12:05 +0000 (GMT)
Message-ID: <6e5d6ab590f18e6ee57c9e6e4bb805c8c223259a.camel@linux.ibm.com>
Subject: Re: [PATCH v10 24/27] ima: Introduce securityfs file to activate an
 IMA namespace
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Date:   Wed, 23 Feb 2022 12:12:05 -0500
In-Reply-To: <9262a630-1f3e-0f58-110d-abfebe8274af@linux.ibm.com>
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
         <20220201203735.164593-25-stefanb@linux.ibm.com>
         <9a720bf5928151a0cbc7994ee498a1c3ca779c56.camel@linux.ibm.com>
         <9262a630-1f3e-0f58-110d-abfebe8274af@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JJc5mqF_CaUs9S4-s0Iyrx8pandaGvzg
X-Proofpoint-ORIG-GUID: wrjrOCkyqYYz1iMH06UsjUEM94jqL-on
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-23_08,2022-02-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 mlxscore=0 clxscore=1015
 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202230097
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2022-02-23 at 12:08 -0500, Stefan Berger wrote:
> On 2/23/22 08:54, Mimi Zohar wrote:
> > On Tue, 2022-02-01 at 15:37 -0500, Stefan Berger wrote:
> >
> >>   int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
> >>   {
> >>   	struct ima_namespace *ns = ima_ns_from_user_ns(user_ns);
> >> @@ -531,6 +596,12 @@ int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
> >>   		}
> >>   	}
> >>   
> >> +	if (ns != &init_ima_ns) {
> >> +		ret = ima_fs_add_ns_files(ima_dir);
> >> +		if (ret)
> >> +			goto out;
> >> +	}
> >> +
> > In all other cases, the securityfs files are directly created in
> > ima_fs_ns_init().   What is different about "active" that a new
> > function is defined?
> 
> 
> It was meant as a function to create namespace-specific files, if more 
> were to come along.  I can move the code from ima_fs_add_ns_files() into 
> this function if you want.

Perhaps defer defining a new function until that happens.

thanks,

Mimi

